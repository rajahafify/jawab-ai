class AddFactoryToChats < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :factory, null: false, foreign_key: true
  end
end
