require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
  end
  
  test "index works" do
    get :index
    assert_response :success
  end
  
  test "save time zone" do
    post :save, :time_zone => "foo"
    @user.reload
    assert_equal "foo", @user.time_zone
  end
end
