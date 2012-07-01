class CreateScrambledWordTests < ActiveRecord::Migration
  def change
    create_table :scrambled_word_tests do |t|
      t.integer :content_id
      t.integer :user_id
      t.integer :wpm
      t.integer :comprehension_rate

      t.timestamps
    end

    add_index :scrambled_word_tests, :content_id
    add_index :scrambled_word_tests, :user_id
  end
end
