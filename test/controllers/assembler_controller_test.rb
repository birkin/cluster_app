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

  test "should get hours_data" do
    get :hours_data
    assert_response :success
  end


end
