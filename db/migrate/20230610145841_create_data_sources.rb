class CreateDataSources < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sources do |t|
      t.references :chat, null: false, foreign_key: true
      t.string :name
      t.integer :source_id, null: false
      t.string :source_type, null: false

      t.timestamps
    end
  end
end
