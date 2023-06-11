class CreateSourceQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :source_question_answers do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
