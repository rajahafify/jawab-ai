class QuestionAnswer < ApplicationRecord
  include Source

  validates :question, presence: true, length: { maximum: 200 }
  validates :answer, presence: true, length: { maximum: 800 }

  def process #=> [String]
    [
      combine_question_answer(question, answer)
    ]
  end

  private

  def combine_question_answer(question, answer)
    "question: #{question} --- answer: #{answer}"
  end
end
