require 'test_helper'

class TaggingRoomControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get tag" do
    get :tag
    assert_response :success
  end

  test "should get find" do
    get :find
    assert_response :success
  end

end
