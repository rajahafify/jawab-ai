class Container < ApplicationRecord
  belongs_to :factory

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end
