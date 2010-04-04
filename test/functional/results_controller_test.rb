require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  def setup
    create_user_and_sign_in
  end
  

  test "should create result" do
    Result.any_instance.expects(:save).returns(true)
    post :create, :result => { }
    assert_response :redirect
  end

  test "should handle failure to create result" do
    Result.any_instance.expects(:save).returns(false)
    post :create, :result => { }
    assert_template "new"
  end

  test "should destroy result" do
    Result.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => results(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy result" do
    Result.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => results(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for result" do
    get :edit, :id => results(:one).to_param
    assert_response :success
  end

  test "should get index for results" do
    get :index
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test "should get new for result" do
    get :new
    assert_response :success
  end

  test "should get show for result" do
    get :show, :id => results(:one).to_param
    assert_response :success
  end

  test "should update result" do
    Result.any_instance.expects(:save).returns(true)
    put :update, :id => results(:one).to_param, :result => { }
    assert_response :redirect
  end

  test "should handle failure to update result" do
    Result.any_instance.expects(:save).returns(false)
    put :update, :id => results(:one).to_param, :result => { }
    assert_template "edit"
  end

end