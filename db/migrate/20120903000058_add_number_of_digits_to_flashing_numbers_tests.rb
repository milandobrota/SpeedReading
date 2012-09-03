class AddNumberOfDigitsToFlashingNumbersTests < ActiveRecord::Migration
  def change
    add_column :flashing_numbers_tests, :number_of_digits, :integer
  end
end
