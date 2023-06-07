# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :factory

  has_many :messages, dependent: :destroy

  def system_prompt
    # [
    #   "You are an AI assistant. You will be asked questions from a",
    #   "customer and will answer in a helpful and friendly manner.",
    #   "You will be provided knowledge_base under the",
    #   "[Article] section. The user will ask question. You will answer the customers questions based on the",
    #   "article. Only provide the answer to the query don't respond with completed part of question.",
    #   "Answer in points and not in long paragraphs",
    #   "If the users question is not relevant or answered by the article you will respond with",
    #   "'I'm sorry I don't know.' Get the user to ask another question that is relevant to #{factory.name}.",
    # ].join(" ")
    "You are a helpful AI assistant. Strictly only the provided articles delimited by triple quotes to answer questions. If the answer cannot be found in the articles, write `I could not find an answer.`"
  end
end
