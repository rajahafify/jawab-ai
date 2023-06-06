# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
end
