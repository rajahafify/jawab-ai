# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  respond_to :html, :turbo_stream
  before_action :authenticate_user!
  before_action :set_chat, only: %i[show]

  def new
    redirect_to Chat.find_or_create_by(user: current_user)
  end

  def show
    respond_with(@chat)
  end

  def create
    @chat = Chat.find_or_create_by(user: current_user)
    redirect_to @chat
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
