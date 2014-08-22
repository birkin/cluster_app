# -*- coding: utf-8 -*-

require 'dotenv'
require 'mysql2'

Dotenv.load


class AssemblerController < ApplicationController

  def index
  end

  def lib_mobile
    @cur_time = Time.now.strftime("%I:%M %P")
    @help_url = ENV['RAILS_CLUSTER_APP_HELP_URL']
    # byebug
  end

  def hours_data
    if not [ "rock", "scili" ].include?( params[:location] )
      render :text => "Bad Request - acceptable locations: 'rock', 'scili'", :status => '400'
    else
      is_open_data = Rails.cache.fetch("foo2", :expires_in => 5.seconds)
      if not is_open_data
        @open_determiner = AssemblerHours.new
        is_open_data = @open_determiner.check_open( params[:location] )
        Rails.cache.write( 'foo2', is_open_data, expires_in: 5.seconds )
      end
      render :json => JSON.pretty_generate( is_open_data )
    end
  end

  # def hours_data
  #   if not [ "rock", "scili" ].include?( params[:location] )
  #     render :text => "Bad Request - acceptable locations: 'rock', 'scili'", :status => '400'
  #   else
  #     @open_determiner = AssemblerHours.new
  #     is_open_data = @open_determiner.check_open( params[:location] )
  #     # render json: is_open_data.to_json
  #     render :json => JSON.pretty_generate( is_open_data )
  #   end
  # end

end
