class AddScheduleTimeToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :scheduled_start, :datetime
    add_column :products, :scheduled_end, :datetime
  end
end
