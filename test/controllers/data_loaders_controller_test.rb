require 'test_helper'

class DataLoadersControllerTest < ActionController::TestCase
  setup do
    @data_loader = data_loaders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_loader)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_loader" do
    assert_difference('DataLoader.count') do
      post :create, data_loader: {  }
    end

    assert_redirected_to data_loader_path(assigns(:data_loader))
  end

  test "should show data_loader" do
    get :show, id: @data_loader
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_loader
    assert_response :success
  end

  test "should update data_loader" do
    patch :update, id: @data_loader, data_loader: {  }
    assert_redirected_to data_loader_path(assigns(:data_loader))
  end

  test "should destroy data_loader" do
    assert_difference('DataLoader.count', -1) do
      delete :destroy, id: @data_loader
    end

    assert_redirected_to data_loaders_path
  end
end
