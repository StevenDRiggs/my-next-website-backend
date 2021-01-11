class AddColumnsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :title, :string
    add_colum :posts, :content, :text
  end
end
