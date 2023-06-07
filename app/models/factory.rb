class Factory < ApplicationRecord
  has_many :containers, dependent: :destroy
  has_many :chats

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: { case_sensitive: false }

end
