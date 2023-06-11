class DataSources::QuestionAnswersController < ApplicationController
  respond_to :html
  before_action :authenticate_user!
  before_action :set_chat

  def new
    @question_answer = QuestionAnswer.new
  end

  def create
    data_source = @chat.data_sources.new(source: QuestionAnswer.new(question_answer_params))
    if data_source.save
      data_source.queue_generate_chunks
      flash[:success] = "Successfully added Question and Answer data source"
      redirect_to @chat
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render 'new'
    end
  end

  private

  def question_answer_params
    params.require(:question_answer).permit(:question, :answer)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
