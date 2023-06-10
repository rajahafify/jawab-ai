class DataSource < ApplicationRecord
  validates :name, presence: true

  delegated_type :source, types: %w[ Source::Text Source::KeyValue ]
end
