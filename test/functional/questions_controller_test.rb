require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
  end
  
  test "should create question" do
    Question.any_instance.expects(:save).returns(true)
    post :create, :question => { }
    assert_response :redirect
  end

  test "should create question with current user" do
    question = Question.new
    Question.expects(:new).with { |values| values[:user_id] == @user.id }.returns(question)
    question.expects(:save).returns(true)
    post :create, :question => { }
    assert_response :redirect
  end

  test "should create question with current user even if user_id is given" do
    question = Question.new
    Question.expects(:new).with { |values| values[:user_id] == @user.id }.returns(question)
    question.expects(:save).returns(true)
    post :create, :question => { :user_id => "123" }
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

  test "should not get other user question on index" do
    user = User.create! :email => "foo", :password => "foo"
    question = Question.create!(:user => user)
    get :index
    assert_response :success
    assert !assigns(:questions).include?(question)
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
  
  [
    [:get, :edit],
    [:post, :update],
    [:get, :show],
    [:delete, :destroy],
  ].each do |method, action|
    test "can not #{method} #{action} other user's question" do
      user = User.create! :email => "bob", :password => "mock"
      question = Question.create! :user => user
      assert_raises ArgumentError do
        send(method, action, :id => question.id.to_s)
      end
    end
  end
end