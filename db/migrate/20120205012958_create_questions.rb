class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.text :answers
      t.integer :content_id
      t.integer :correct_answer

      t.timestamps
    end

    add_index :questions, :content_id
  end
end
