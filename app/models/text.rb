class Text < ApplicationRecord
  include Source

  validates :content, presence: true

  CHUNK_MAX_LENGTH = 1000 # Maximum length of each chunk

  def process
    content_words = tokenize_content(content)
    chunks = split_into_chunks(content_words)
    save_chunks(chunks)
  end

  private

  def tokenize_content(content)
    content.scan(/[\w']+/)
  end

  def split_into_chunks(content_words)
    chunks = []
    current_chunk = ""

    content_words.each do |word|
      if (current_chunk + " " + word).length <= CHUNK_MAX_LENGTH
        current_chunk += " " + word
      else
        chunks << current_chunk.strip unless current_chunk.empty?
        current_chunk = word
      end
    end

    chunks << current_chunk.strip unless current_chunk.empty?

    chunks
  end

  def save_chunks(chunks)
    chunks.each do |chunk|
      p chunk
      # DataSource::Chunk.create(text_id: id, content: chunk)
    end
  end
end
