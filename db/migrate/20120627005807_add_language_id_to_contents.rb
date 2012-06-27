class AddLanguageIdToContents < ActiveRecord::Migration
  def change
    add_column :contents, :language_id, :integer
    add_index :contents, :language_id
  end
end
