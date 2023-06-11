class Source::QuestionAnswer < ApplicationRecord
  validate :question, presence: true, length: { maximum: 200 }, allow_blank: false
  validate :answer, presence: true, length: { maximum: 1000 }, allow_blank: false
end
