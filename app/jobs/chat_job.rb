class ChatJob < ApplicationJob
  def perform(chat_id, task)
    return unless respond_to? task
    send(task, chat_id)
  end

  def respond(chat_id)
    Chat.find(chat_id).respond
  end
end
