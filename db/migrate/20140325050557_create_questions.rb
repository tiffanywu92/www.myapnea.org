class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_text
      t.integer :question_type_id
      t.integer :answer_type_id

      t.timestamps
    end
  end
end