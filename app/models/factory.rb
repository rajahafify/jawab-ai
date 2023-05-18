class Factory < ApplicationRecord
  has_many :containers, dependent: :destroy

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: { case_sensitive: false }
end
