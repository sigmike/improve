require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
    @question = Question.create :user => @user
  end
  

  test "should create result" do
    Result.any_instance.expects(:save).returns(true)
    post :create, :result => { :question_id => @question.id }
    assert_response :redirect
  end

  test "should not allow creation when question is owned by another users" do
    question = Question.create :user => users(:two)
    assert_raises ArgumentError do
      post :create, :result => { :question_id => question.id.to_s }
    end
  end

  test "should handle failure to create result" do
    Result.any_instance.expects(:save).returns(false)
    post :create, :result => { :question_id => @question.id }
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
    put :update, :id => results(:one).to_param, :result => { :question_id => results(:one).question_id }
    assert_response :redirect
  end

  test "should handle failure to update result" do
    Result.any_instance.expects(:save).returns(false)
    put :update, :id => results(:one).to_param, :result => { :question_id => results(:one).question_id }
    assert_template "edit"
  end
  
  test "should not allow update on other user's question" do
    question = Question.create :user => users(:two)
    assert_raises ArgumentError do
      put :update, :id => results(:one).to_param, :result => { :question_id => question.id }
    end
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
      result = Result.create! :question => question
      assert_raises ArgumentError do
        send(method, action, :id => result.id.to_s)
      end
    end
  end
end