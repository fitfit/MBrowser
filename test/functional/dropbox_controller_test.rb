require 'test_helper'

class DropboxControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
