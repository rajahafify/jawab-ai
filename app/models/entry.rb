class Entry < ApplicationRecord
  belongs_to :container

  validates :title, presence: true
end
