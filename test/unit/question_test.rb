require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "results are destroyed when question is destroyed" do
    question = questions(:one)
    assert Result.count(:conditions => ["question_id = ?", question.id]) > 0
    question.destroy
    assert Result.count(:conditions => ["question_id = ?", question.id]) == 0
  end
end
