require 'test_helper'

class TestControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    sign_in @user
  end
  
  test "save" do
    q1 = Question.create!
    q2 = Question.create!
    assert_difference "Result.count", +2 do
      post :save,
        "result"=> { q1.id.to_s => "0.254", q2.id.to_s => "0.6"},
        "save"=> { q1.id.to_s => "1", q2.id.to_s => "1"},
        "date" => {"minute"=>"05", "month"=>"4", "hour"=>"12", "day"=>"4", "year"=>"2010"}
    end
    assert_response :success
    
    r1, r2 = Result.all[-2..-1].sort_by { |result| result.question_id }
    date = DateTime.new(2010, 4, 4, 12, 5)
    
    assert_equal q1, r1.question
    assert_equal 0.254, r1.value
    assert_equal date, r1.date
    assert_equal q2, r2.question
    assert_equal 0.6, r2.value
    assert_equal date, r2.date
  end

  test "save only checked results" do
    q1 = Question.create!
    q2 = Question.create!
    assert_difference "Result.count", +1 do
      post :save,
        "result"=> { q1.id.to_s => "0.254", q2.id.to_s => "0.6"},
        "save"=> { q2.id.to_s => "1"},
        "date" => {"minute"=>"05", "month"=>"4", "hour"=>"12", "day"=>"4", "year"=>"2010"}
    end
    assert_response :success
    
    r2 = Result.last
    date = DateTime.new(2010, 4, 4, 12, 5)
    
    assert_equal q2, r2.question
    assert_equal 0.6, r2.value
    assert_equal date, r2.date
  end

  test "save uses user time zone" do
    @user.time_zone = "Paris"
    @user.save!
    q1 = Question.create! :user => @user
    assert_difference "Result.count", +1 do
      post :save,
        "result"=> { q1.id.to_s => "0.254"},
        "save"=> { q1.id.to_s => "1"},
        "date" => {"minute"=>"05", "month"=>"4", "hour"=>"12", "day"=>"4", "year"=>"2010"}
    end
    assert_response :success
    
    r1 = Result.last
    date = ActiveSupport::TimeZone["Paris"].local(2010, 4, 4, 12, 5)
    
    assert_equal date, r1.date
  end
end
