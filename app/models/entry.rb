class Entry < ApplicationRecord
  has_neighbors :embedding

  belongs_to :container

  validates :title, presence: true

  before_save :set_embedding

  private

  def set_embedding
    response = AIService.new.embed(content)
    self.embedding = response.dig("data", 0, "embedding")
    self.token_count = response.dig("usage", "total_tokens")
  end
end
