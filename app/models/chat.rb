# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :factory

  has_many :messages, dependent: :destroy

  after_create_commit { create_initial_message }

  def queue
    GetAIResponse.perform_now(id)
  end

  def respond
    ai_service
      .chat(
        conversation: conversation_with_user_prompt, 
        stream_proc: Proc.new do |chunk, _bytesize|
          new_content = chunk.dig("choices", 0, "delta", "content")
          puts new_content
          response.update(content: response.content + new_content) if new_content
        end
      )
  end

  private

  def response
    messages.create(role: :assistant, content: "")
  end

  def stream_proc(response:)
    
  end

  def ai_service
    @ai_service ||= AIService.new
  end

  def create_initial_message
    messages.create(role: :system, content: system_prompt)
    messages.create(role: :assistant, content: "How can I help you?")
  end

  def system_prompt
    [
      "You are a helpful AI assistant.",
      "Strictly only the provided articles delimited by",
      "triple quotes to answer questions.",
      "If the answer cannot be found in the articles,",
      "write `I could not find an answer.`",
    ].join(" ")
  end

  def conversation_with_user_prompt
    conversation_context
      .push(
        { 
          role: :user, 
          content: user_prompt 
        }
      )
  end

  def conversation_context
    conversation[0...-1]
  end

  def conversation
    Message.for_openai(messages.order(created_at: :asc))
  end

  def user_prompt
    "'''#{knowledge_base}''' question: #{conversation.last[:content]}"
  end

  def knowledge_base
    embedding = ai_service.embed(conversation_context.to_s).dig("data", 0, "embedding")
    factory.entries.nearest_neighbors(:embedding, embedding, distance: "euclidean").limit(3)&.pluck(:content)&.join(",").presence || ""
  end
end
