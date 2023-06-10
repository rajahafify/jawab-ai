class Container < ApplicationRecord
  has_many :entries, dependent: :destroy
  belongs_to :factory

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end
