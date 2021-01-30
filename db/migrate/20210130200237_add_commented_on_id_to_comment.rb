class AddCommentedOnIdToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :commented_on_id, :integer
  end
end
