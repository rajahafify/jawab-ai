class DataChunk < ApplicationRecord
  has_neighbors :embedding

  belongs_to :data_source

  def source
    data_source.source
  end
end
