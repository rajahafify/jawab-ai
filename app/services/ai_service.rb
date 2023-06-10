class AIService

  def initialize
    @client = OpenAI::Client.new
  end

  def list
    @client.models.list
  end

  def chat(conversation:, stream_proc:)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: conversation,
        temperature: 0.2,
        stream: stream_proc
      }
    )
  end
  
  def embed(text)
    @client.embeddings(
      parameters: {
        model: "text-embedding-ada-002",
        input: text
      }
    )
  end


end
