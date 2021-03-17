class Product < ApplicationRecord
  validates :name, :price, :scheduled_start, :scheduled_end, presence: true
  
  scope :no_price, -> { where("price IS NULL") }
  scope :order_by_schedueldstart, -> (column = 'scheduled_start',ordered) { order("#{column} #{ordered}") if ordered}

  def noStock
    self.stock == 0
  end
end