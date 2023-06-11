# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!

  def create
    @message = Message.find_or_create_by(message_params.merge(chat_id: params[:chat_id], role: "user"))
    @message.chat.queue_respond

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
