require 'test_helper'


class RedirectsTest < ActionDispatch::IntegrationTest

  test 'hours_data with no location should redirect before it hits controller' do
    get '/hours_data'
    assert_redirected_to '/hours_data/rock'
  end

end
