class CreateWordSearchTests < ActiveRecord::Migration
  def change
    create_table :word_search_tests do |t|
      t.integer :content_id
      t.integer :user_id
      t.integer :score

      t.timestamps
    end

    add_index :word_search_tests, :content_id
    add_index :word_search_tests, :user_id
  end
end
