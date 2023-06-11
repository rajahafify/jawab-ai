class CreateDataChunks < ActiveRecord::Migration[7.0]
  def change
    create_table :data_chunks do |t|
      t.references :data_source, null: false, foreign_key: true
      t.text :content
      t.integer :token_count
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
