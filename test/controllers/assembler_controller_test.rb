require 'test_helper'

class AssemblerControllerTest < ActionController::TestCase
  test "should get index,lib_mobile" do
    get :index,lib_mobile
    assert_response :success
  end

end
