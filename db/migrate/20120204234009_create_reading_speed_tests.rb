class CreateReadingSpeedTests < ActiveRecord::Migration
  def change
    create_table :reading_speed_tests do |t|
      t.integer :content_id
      t.integer :user_id
      t.integer :wpm

      t.timestamps
    end

    add_index :reading_speed_tests, :content_id
    add_index :reading_speed_tests, :user_id
  end
end
