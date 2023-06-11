class DataSources::TextsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!
  before_action :set_chat

  def new
    @text = Text.new
  end

  def create
    data_source = @chat.data_sources.new(source: Text.new(texts_params))
    if data_source.save
      data_source.queue_generate_chunks
      flash[:success] = "Successfully added Text data source"
      redirect_to @chat
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render 'new'
    end
  end

  private

  def texts_params
    params.require(:text).permit(:content)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
