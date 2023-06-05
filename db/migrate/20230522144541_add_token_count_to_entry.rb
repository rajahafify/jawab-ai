class AddTokenCountToEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :token_count, :integer
  end
end
