class DataSource < ApplicationRecord
  delegated_type :source, types: %w[ Text QuestionAnswer ]

  delegate :process, to: :source

  has_many :data_chunks, dependent: :destroy

  belongs_to :chat

  def queue_generate_chunks
    DataSourceJob.perform_later(id, :generate_chunks)
  end

  def generate_chunks
    process.each do |chunk|
      ai_service = AIService.new
      vector = ai_service.embed(chunk)
      DataChunk.create(
        content: chunk,
        embedding: vector.dig("data", 0, "embedding"),
        token_count: vector.dig("usage", "total_tokens"),
        data_source: self
      )
    end
  end
end
