class SetNameDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :user, :name, "user"
  end
end
