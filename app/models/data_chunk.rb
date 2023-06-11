class DataChunk < ApplicationRecord
  has_neighbors :embedding

  belongs_to :data_source

  def source
    data_source.source
  end

  def nearby_neighbors limit=3
    nearest_neighbors(:embedding, distance: "euclidean").first(limit).map(&:content)
  end
end
