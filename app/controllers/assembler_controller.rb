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
      @open_determiner = AssemblerHours.new
      is_open_data = @open_determiner.check_open( params[:location] )
      render json: is_open_data.to_json
    end
  end

  # def hours_data
  #   @open_determiner = AssemblerHours.new
  #   is_open_data = @open_determiner.check_open
  #   render json: is_open_data.to_json
  # end

  # def hours_data
  #   render text: params[ :location ]
  #   render :json => JSON.pretty_generate( is_open_data )
  # end

end
