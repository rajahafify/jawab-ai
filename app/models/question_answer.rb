class QuestionAnswer < ApplicationRecord
  include Source

  validates :question, presence: true, length: { maximum: 200 }
  validates :answer, presence: true, length: { maximum: 800 }

  def process
    combined_content = combine_question_answer(question, answer)
    save_chunks(combined_content)
  end

  private

  def combine_question_answer(question, answer)
    "question: #{question} --- answer: #{answer}"
  end

  def save_chunks(combined_content)
    p combined_content
    # DataSource::Chunk.new(source: content: )
  end
end
