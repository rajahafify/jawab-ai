class AIService

  def initialize
    @client = OpenAI::Client.new
  end

  def list
    @client.models.list
  end

  # response = client.chat(
  #     parameters: {
  #         model: "gpt-3.5-turbo", # Required.
  #         messages: [{ role: "user", content: "Hello!"}], # Required.
  #         temperature: 0.7,
  #     })
  # puts response.dig("choices", 0, "message", "content")
  # => "Hello! How may I assist you today?"

  # def chat
  #   @client.chat(
  #     parameters: {
  #       model: "gpt-3.5-turbo",
  #       messages: [{ role: "user", content: "Hello!"}],
  #       temperature: 0,
  #     }
  #   )
  # end

  # client.embeddings(
  #     parameters: {
  #         model: "babbage-similarity",
  #         input: "The food was delicious and the waiter..."
  #     }
  # )
  
  def embed(text)
    @client.embeddings(
      parameters: {
        model: "text-embedding-ada-002",
        input: text
      }
    )
  end
end
