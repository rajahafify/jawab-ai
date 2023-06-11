class DataSourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def show
    @data_source = @chat.data_sources.find(params[:id])
  end

  def destroy
    data_source = @chat.data_sources.find(params[:id])
    data_source.transaction do
      data_source.source.destroy
      data_source.destroy
      redirect_to @chat, notice: "Data Source #{params[:id]} destroyed"
    end

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
    redirect_to @chat, notice: "Fail to delete data source"
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
