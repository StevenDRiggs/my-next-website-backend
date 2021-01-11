class CreateCommentors < ActiveRecord::Migration[6.0]
  def change
    create_table :commentors do |t|
      t.string :password_digest
      t.text :liked_posts
      t.string :avatar_url

      t.timestamps
    end
  end
end
