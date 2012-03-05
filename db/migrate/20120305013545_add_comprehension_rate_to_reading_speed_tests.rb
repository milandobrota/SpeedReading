class AddComprehensionRateToReadingSpeedTests < ActiveRecord::Migration
  def change
    add_column :reading_speed_tests, :comprehension_rate, :integer
  end
end
