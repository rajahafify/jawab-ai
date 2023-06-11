class DataSourcesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @chat = Chat.find(params[:chat_id])
    data_source = @chat.data_sources.find(params[:id])
    data_source.transaction do
      data_source.source.destroy
      data_source.destroy
      redirect_to @chat, notice: "Data Source #{params[:id]} destroyed"
    end

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
    redirect_to @chat, notice: "Fail to delete data source"
  end
end
