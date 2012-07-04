class CreateSynonymsAndAntonymsTests < ActiveRecord::Migration
  def change
    create_table :synonyms_and_antonyms_tests do |t|
      t.integer :user_id
      t.integer :speed
      t.integer :accuracy

      t.timestamps
    end
 
  end
end
