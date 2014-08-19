require 'test_helper'

class AssemblerHoursTest < ActiveSupport::TestCase

  setup do
  end

  ## test get_open_status()

  test "test perceive open status" do
    source_hash = {
      :date => "2014-08-15",
      :isclosed => "n",
      :opentime => "2000-01-01T08:30:01.000-05:00",
      :closetime => "2000-01-01T21:00:02.000-05:00"
      }
    asmblr = AssemblerHours.new
    enhanced_data = asmblr.get_open_status( source_hash )
    assert_equal( "open", enhanced_data[:closed_status], "PROBLEM" )
  end

  test "test perceive closed status" do
    source_hash = {
      :date => "2014-08-15",
      :isclosed => "y",
      :opentime => "2000-01-01T08:30:01.000-05:00",
      :closetime => "2000-01-01T21:00:02.000-05:00"
      }
    asmblr = AssemblerHours.new
    enhanced_data = asmblr.get_open_status( source_hash )
    assert_equal( "closed", enhanced_data[:closed_status], "PROBLEM" )
  end

end
