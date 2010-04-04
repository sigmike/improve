require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
  end
  
  test "should create activity" do
    Activity.any_instance.expects(:save).returns(true)
    post :create, :activity => { }
    assert_response :redirect
  end

  test "should handle failure to create activity" do
    Activity.any_instance.expects(:save).returns(false)
    post :create, :activity => { }
    assert_template "new"
  end

  test "should create activity with current user" do
    activity = Activity.new
    Activity.expects(:new).with { |values| values[:user_id] == @user.id }.returns(activity)
    activity.expects(:save).returns(true)
    post :create, :activity => { }
    assert_response :redirect
  end

  test "should destroy activity" do
    Activity.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => activities(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy activity" do
    Activity.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => activities(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for activity" do
    get :edit, :id => activities(:one).to_param
    assert_response :success
  end

  test "should get index for activities" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end

  test "should get new for activity" do
    get :new
    assert_response :success
  end

  test "should get show for activity" do
    get :show, :id => activities(:one).to_param
    assert_response :success
  end

  test "should update activity" do
    Activity.any_instance.expects(:save).returns(true)
    put :update, :id => activities(:one).to_param, :activity => { }
    assert_response :redirect
  end

  test "should handle failure to update activity" do
    Activity.any_instance.expects(:save).returns(false)
    put :update, :id => activities(:one).to_param, :activity => { }
    assert_template "edit"
  end

end