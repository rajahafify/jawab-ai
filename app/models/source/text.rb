class Source::Text < ApplicationRecord
  validate :text, presence: true
end
