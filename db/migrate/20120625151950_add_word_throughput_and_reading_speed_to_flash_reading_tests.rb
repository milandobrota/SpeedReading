class AddWordThroughputAndReadingSpeedToFlashReadingTests < ActiveRecord::Migration
  def change
    add_column :flash_reading_tests, :word_throughput, :integer
    add_column :flash_reading_tests, :reading_speed, :integer
  end
end
