class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :body
      t.string :source_name
      t.string :source_link

      t.timestamps
    end
  end
end
