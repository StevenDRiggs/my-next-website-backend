class AddFlagsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :flags, :text
  end
end
