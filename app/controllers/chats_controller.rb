# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  respond_to :html, :turbo_stream

  before_action :authenticate_user!, except: :index
  before_action :set_chat, only: %i[show destroy]

  def index
    @chats = current_user&.chats || []
  end

  def show
  end

  def create
    @chat = current_user.chats.create
    redirect_to @chat
  end

  def destroy
    @chat.destroy
    redirect_to root_path
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

end
