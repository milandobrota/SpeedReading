class CreateFlashReadingTests < ActiveRecord::Migration
  def change
    create_table :flash_reading_tests do |t|
      t.integer :content_id
      t.integer :user_id

      t.timestamps
    end

    add_index :flash_reading_tests, :content_id
    add_index :flash_reading_tests, :user_id
  end
end
