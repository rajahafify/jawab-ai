class CreateFactories < ActiveRecord::Migration[7.0]
  def change
    create_table :factories do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description, null: false
      t.string :url, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
