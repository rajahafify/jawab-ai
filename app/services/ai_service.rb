class AIService
  def initialize
    @client = OpenAI::Client.new
  end

  def list
    @client.models.list
  end

  def chat(conversation:, response:)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: conversation,
        temperature: 0.2,
        stream: stream_proc(response: response)
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

  def summarize(array)
    response = @client.completions(
      parameters: {
          model: "text-davinci-003",
          prompt: "Summarize the following text in 10 words: #{array}",
          max_tokens: 50
      }
    )
    response.dig("choices", 0, "text").strip
  end

  private

  def stream_proc(response:)
    proc do |chunk, _bytesize|
      new_content = chunk.dig("choices", 0, "delta", "content")
      response.update(content: response.content + new_content) if new_content
    end
  end
end
