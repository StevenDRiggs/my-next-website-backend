class SetUsernamePasswordDigestIsAdminToNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :username, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :is_admin, false
  end
end
