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
      vector = ai_service.embed(chunk)
      DataChunk.create(
        content: chunk,
        embedding: vector.dig("data", 0, "embedding"),
        token_count: vector.dig("usage", "total_tokens"),
        data_source: self
      )
    end
    self.update!(summary: ai_service.summarize(data_chunks.limit(3).map(&:content)))
  end

  def ai_service
    @AIService ||= AIService.new
  end
end
