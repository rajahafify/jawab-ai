# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  respond_to :html, :turbo_stream

  before_action :authenticate_user!
  before_action :set_factory
  before_action :set_chat, only: %i[show destroy]

  def show
  end

  def create
    @chat = @factory.chats.create!(user: current_user)
    redirect_to [@factory, @chat]
  end

  def destroy
    @chat.destroy
    redirect_to @factory
  end

  private

  def set_chat
    @chat = @factory.chats.find(params[:id])
  end

  def set_factory
    @factory = Factory.find(params[:factory_id])
  end
end
