class EditUserColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :name, true)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password, false)
  end
end
