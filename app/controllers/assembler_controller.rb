# -*- coding: utf-8 -*-


class AssemblerController < ApplicationController

  def index
  end

  def lib_mobile
    @cur_time = Time.now.strftime("%I:%M %P")
    # byebug
  end

  def hours_data
    # render json: { a: 1, b: 2}.to_json
    @open_determiner = AssemblerHours.new
    is_open_data = @open_determiner.check_open
    render json: is_open_data.to_json
  end

end
