require 'dotenv'
require 'mysql2'

Dotenv.load


class AssemblerHours

  def initialize
    @foo = 'bar'
  end

  def check_open
    time_arg = Time.now.getutc.to_s
    date_arg = get_date_arg()
    results = query_db( date_arg )
    db_data = get_row_data( results )
    data_hash = db_data
  end

  private
  def get_date_arg
    ## Returns date_string for db query.
    ## Set manually for now, but eventually could be passed in.
    date_arg = Time.now.getutc.to_date.to_s
  end

  private
  def query_db( time_arg )
    time_arg = Date.today.to_s
    # byebug
    client = Mysql2::Client.new(
      :host => ENV['RAILS_CLUSTER_APP_DB_DOMAIN'],
      :username => ENV['RAILS_CLUSTER_APP_DB_USER'],
      :password => ENV['RAILS_CLUSTER_APP_DB_PASSWORD'],
      :secure_auth => false,
      :database => ENV['RAILS_CLUSTER_APP_DB_NAME']
    )
    select_statement = "SELECT * from `hours_rock` WHERE `date` = '#{time_arg}'"
    results = client.query( select_statement, :symbolize_keys => true )
  end

  def get_row_data( results )
    row_data = nil
    results.each do |row|
      row_data = row
      break
    end
    return row_data
  end

  def get_open_status( db_data )
    if db_data[:isclosed].to_s == 'n'
      open_status = 'open'
    else
      open_status = 'closed'
    end
  end

  def get_time_opened( db_data, time_arg )
    return 'foo'
    open_time = db_data[:opentime]

  end

  def build_response_hash( time_arg )
    data_hash = {
      :request_timestamp => time_arg,
      :response => {
        :queried_date => 'foo_b',
        :queried_date_time_open => 'foo_c',
        :queried_date_time_close => 'foo_d',
        :currently_open => 'foo_e'
      }
    }
  end

end
