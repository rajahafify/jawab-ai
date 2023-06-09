# app/jobs/get_ai_response.rb
class GetAIResponse < ApplicationJob
  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    knowledge_base = "Company Name: #{chat.factory.name}, Company Description: #{chat.factory.description}"
    user_prompt = 
      "
        [Article]
        #{knowledge_base}

        [Question]
        #{chat.messages.order(created_at: :asc).last.content}
      "
    chat.messages.find_or_create_by(role: :system).update(content: chat.system_prompt)
    messages = Message.for_openai(chat.messages.order(created_at: :asc))[0...-1]
    messages.push({ role: :user, content: user_prompt })

    response = chat.messages.create(role: :assistant, content: "")
    OpenAI::Client.new.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 0.2,
        stream: stream_proc(message: response)
      }
    )
  end

  def stream_proc(message:)
    proc do |chunk, _bytesize|
      new_content = chunk.dig("choices", 0, "delta", "content")
      message.update(content: message.content + new_content) if new_content
    end
  end
end
