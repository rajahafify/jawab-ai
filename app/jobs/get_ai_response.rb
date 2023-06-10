# app/jobs/get_ai_response.rb
class GetAIResponse < ApplicationJob
  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  def call_openai(chat:)
    chat.respond
  end
end
