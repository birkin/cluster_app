require 'test_helper'

class AssemblerControllerTest < ActionController::TestCase

  # test "should get index,lib_mobile" do
  #   get :index,lib_mobile
  #   assert_response :success
  # end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get lib_mobile" do
    get :lib_mobile
    assert_response :success
  end

  # test "should get hours_data" do
  #   get :hours_data
  #   assert_response :success
  # end

  test "should get hours_data with location" do
    get( :hours_data, {'location' => "rock"} )
    assert_response :success
  end

  test "hours_data with bad location should 404" do
    get( :hours_data, {'location' => "foo"} )
    assert_response 404
  end

  test "hours_data with location routing" do
    assert_routing '/hours_data/rock', { :controller => "assembler", :action => "hours_data", :location => "rock" }
  end

  # test "hours_data with _no_ location routing" do
  #   # assert_routing '/hours_data', { :controller => "assembler", :action => "hours_data", :location => "rock" }
  # end

end
