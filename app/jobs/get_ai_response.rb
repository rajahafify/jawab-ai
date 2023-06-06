# app/jobs/get_ai_response.rb
class GetAIResponse < ApplicationJob
  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: "assistant", content: "")

    OpenAI::Client.new.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: Message.for_openai(chat.messages),
        temperature: 0.1,
        stream: stream_proc(message: message)
      }
    )
  end

  def stream_proc(message:)
    proc do |chunk, _bytesize|
      new_content = chunk.dig("choices", 0, "delta", "content")
      p new_content
      message.update(content: message.content + new_content) if new_content

      message.broadcast_updated
    end
  end
end
