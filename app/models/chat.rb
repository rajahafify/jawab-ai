# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :user

  has_many :messages, dependent: :destroy

  has_many :data_sources, dependent: :destroy

  after_create_commit { create_initial_message }

  def queue_respond
    ChatJob.perform_later(id, :respond)
  end

  def respond
    ai_service
      .chat(
        conversation: conversation_with_user_prompt, 
        response: response 
      )
  end

  private

  def response
    messages.create(role: :assistant, content: "")
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
      "Respond with the same language as the question",
      "Strictly only the provided data source delimited by",
      "triple quotes to answer questions.",
      "If the answer cannot be found in the data source,",
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

  def conversation_context_vector
    ai_service.embed(conversation.last[:content]).dig("data", 0, "embedding")
  end

  def knowledge_base
    chunks = DataChunk.nearest_neighbors(:embedding, conversation_context_vector, distance: "euclidean").first(3).map(&:content)
    puts chunks
    chunks
  end
end
