class DataSourceJob < ApplicationJob
  def perform(data_source_id, task)
    return unless respond_to? task
    send(task, data_source_id)
  end

  def generate_chunks(id)
    DataSource.find(id).generate_chunks
  end
end
