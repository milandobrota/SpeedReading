class CreateFlashingNumbersTests < ActiveRecord::Migration
  def change
    create_table :flashing_numbers_tests do |t|
      t.integer :content_id
      t.integer :user_id
      t.integer :distance

      t.timestamps
    end

    add_index :flashing_numbers_tests, :content_id
    add_index :flashing_numbers_tests, :user_id
  end
end
