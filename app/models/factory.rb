class Factory < ApplicationRecord
  has_many :containers, dependent: :destroy
  has_many :chats
  has_many :entries, through: :containers

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: { case_sensitive: false }

end
