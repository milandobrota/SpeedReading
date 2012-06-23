class RemoveContentIdFromFlashingNumbersTests < ActiveRecord::Migration
  def up
    remove_index :flashing_numbers_tests, :content_id
    remove_column :flashing_numbers_tests, :content_id
  end

  def down
    add_column :flashing_numbers_tests, :content_id, :integer
    add_index :flashing_numbers_tests, :content_id
  end
end
