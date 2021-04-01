class AddAdminColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :user, :admin, :boolean, default: false
  end
end
