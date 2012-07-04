class CreateWordPairs < ActiveRecord::Migration
  def change
    create_table :word_pairs do |t|
      t.string :word_1
      t.string :word_2
      t.boolean :synonyms

      t.timestamps
    end
  end
end
