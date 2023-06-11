class AddSummaryToDataSources < ActiveRecord::Migration[7.0]
  def change
    add_column :data_sources, :summary, :string, default: "No summary"
  end
end
