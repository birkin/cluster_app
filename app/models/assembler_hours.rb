# -*- coding: utf-8 -*-

require 'dotenv'
require 'mysql2'
require 'time'

Dotenv.load


class AssemblerHours

  def initialize
    @foo = 'bar'
  end

  def check_open( location )
    ## Accesses db data & returns hash.
    ## Main controller.
    request_time = Time.now.to_s
    queried_date = Date.today.to_s  # eventually pass this in
    results = query_db( queried_date, location )
    db_data = get_row_data( results )
    open_closed_status = get_open_status( db_data )
    response_hash = build_response_hash( request_time, queried_date, location, open_closed_status, db_data )
    return response_hash
  end

  # def check_open
  #   ## Accesses db data & returns hash.
  #   ## Main controller.
  #   request_time = Time.now.to_s
  #   queried_date = Date.today.to_s  # eventually pass this in
  #   results = query_db( queried_date )
  #   db_data = get_row_data( results )
  #   db_data_b = get_open_status( db_data )
  #   response_hash = build_response_hash( request_time, queried_date, db_data_b )
  #   return response_hash
  # end

  private
  def query_db( date_string, location )
    ## Queries db; returns resultset hash.
    ## Called by check_open()
    converter = { 'rock' => 'hours_rock', 'scili' => 'hours_sci' }  # url location => table sql
    client = Mysql2::Client.new(
      :host => ENV['RAILS_CLUSTER_APP_DB_DOMAIN'],
      :username => ENV['RAILS_CLUSTER_APP_DB_USER'],
      :password => ENV['RAILS_CLUSTER_APP_DB_PASSWORD'],
      :secure_auth => false,
      :database => ENV['RAILS_CLUSTER_APP_DB_NAME']
    )
    select_statement = "SELECT * from `#{converter[location]}` WHERE `date` = '#{date_string}'"
    results = client.query( select_statement, :symbolize_keys => true )
  end

  # def query_db( date_string )
  #   ## Queries db; returns resultset hash.
  #   ## Called by check_open()
  #   client = Mysql2::Client.new(
  #     :host => ENV['RAILS_CLUSTER_APP_DB_DOMAIN'],
  #     :username => ENV['RAILS_CLUSTER_APP_DB_USER'],
  #     :password => ENV['RAILS_CLUSTER_APP_DB_PASSWORD'],
  #     :secure_auth => false,
  #     :database => ENV['RAILS_CLUSTER_APP_DB_NAME']
  #   )
  #   select_statement = "SELECT * from `hours_rock` WHERE `date` = '#{date_string}'"
  #   results = client.query( select_statement, :symbolize_keys => true )
  # end

  private
  def get_row_data( results )
    ## Returns hash of first (only) row of results.
    ## Called by check_open()
    row_data = nil
    results.each do |row|
      row_data = row
      break
    end
    return row_data
  end

  public
  def get_open_status( db_data )
    ## Returns open/closed string.
    ## Called by check_open()
    if db_data[:isclosed].to_s == 'n'
      open_status = 'open'
    else
      open_status = 'closed'
    end
  end

  # def make_open_close_times( time_string )
  #   tm = Time.parse( time_string )
  #   return 'foo'
  # end

  def build_response_hash( request_time, queried_date, location, open_closed_status, db_data )
    ## Returns hash.
    ## Called by check_open()
    data_hash = {
      :request_timestamp => request_time,
      :response => {
        :queried_date => queried_date,
        :queried_location => location,
        :open_closed_status => open_closed_status,
        :raw_data => db_data
      }
    }
  end

end
