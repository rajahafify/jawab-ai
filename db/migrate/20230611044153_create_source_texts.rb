class CreateSourceTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :source_texts do |t|
      t.text :data, null: false

      t.timestamps
    end
  end
end
