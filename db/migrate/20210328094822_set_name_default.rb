class SetNameDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :name, "user"
  end
end
