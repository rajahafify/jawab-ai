class AddNeighborVectorToEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :embedding, :vector, limit: 1536
  end
end
