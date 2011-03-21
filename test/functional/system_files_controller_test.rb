require 'test_helper'

class SystemFilesControllerTest < ActionController::TestCase
  setup do
    @system_file = system_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_file" do
    assert_difference('SystemFile.count') do
      post :create, :system_file => @system_file.attributes
    end

    assert_redirected_to system_file_path(assigns(:system_file))
  end

  test "should show system_file" do
    get :show, :id => @system_file.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @system_file.to_param
    assert_response :success
  end

  test "should update system_file" do
    put :update, :id => @system_file.to_param, :system_file => @system_file.attributes
    assert_redirected_to system_file_path(assigns(:system_file))
  end

  test "should destroy system_file" do
    assert_difference('SystemFile.count', -1) do
      delete :destroy, :id => @system_file.to_param
    end

    assert_redirected_to system_files_path
  end
end
