class DataSource < ApplicationRecord
  validates :name, presence: true

  delegated_type :source, types: %w[ Text QuestionAnswer ]

  delegate :process, to: :source
end
