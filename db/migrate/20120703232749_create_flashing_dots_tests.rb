class CreateFlashingDotsTests < ActiveRecord::Migration
  def change
    create_table :flashing_dots_tests do |t|
      t.integer :user_id
      t.integer :level
      t.timestamps
    end

    add_index :flashing_dots_tests, :user_id
  end
end
