class DataSource < ApplicationRecord
  validates :name, presence: true

  delegated_type :source, types: %w[ Source::Document Source::QuestionAnswer ]
end
