class AddColumnsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :commentor_id, :integer
    add_column :commemts, :content, :text
    add_column :comments, :likes, :integer
  end
end
