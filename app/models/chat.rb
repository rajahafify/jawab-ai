# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :factory

  has_many :messages, dependent: :destroy

  def prompt
    ""
  end
end
