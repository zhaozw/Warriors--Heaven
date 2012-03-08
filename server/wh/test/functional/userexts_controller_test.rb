require 'test_helper'

class UserextsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userext" do
    assert_difference('Userext.count') do
      post :create, :userext => { }
    end

    assert_redirected_to userext_path(assigns(:userext))
  end

  test "should show userext" do
    get :show, :id => userexts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => userexts(:one).to_param
    assert_response :success
  end

  test "should update userext" do
    put :update, :id => userexts(:one).to_param, :userext => { }
    assert_redirected_to userext_path(assigns(:userext))
  end

  test "should destroy userext" do
    assert_difference('Userext.count', -1) do
      delete :destroy, :id => userexts(:one).to_param
    end

    assert_redirected_to userexts_path
  end
end
