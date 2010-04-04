require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  test "should create question" do
    Question.any_instance.expects(:save).returns(true)
    post :create, :question => { }
    assert_response :redirect
  end

  test "should handle failure to create question" do
    Question.any_instance.expects(:save).returns(false)
    post :create, :question => { }
    assert_template "new"
  end

  test "should destroy question" do
    Question.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => questions(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy question" do
    Question.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => questions(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for question" do
    get :edit, :id => questions(:one).to_param
    assert_response :success
  end

  test "should get index for questions" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new for question" do
    get :new
    assert_response :success
  end

  test "should get show for question" do
    get :show, :id => questions(:one).to_param
    assert_response :success
  end

  test "should update question" do
    Question.any_instance.expects(:save).returns(true)
    put :update, :id => questions(:one).to_param, :question => { }
    assert_response :redirect
  end

  test "should handle failure to update question" do
    Question.any_instance.expects(:save).returns(false)
    put :update, :id => questions(:one).to_param, :question => { }
    assert_template "edit"
  end

end