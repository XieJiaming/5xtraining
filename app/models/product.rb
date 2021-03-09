class Product < ApplicationRecord
  validates :name, presence: true
  # scope :no_price, -> { where(:price => nil) }
  scope :no_price, -> { where("price is null") }
  # def self.no_price 
  #   where(:price => nil)
  # end

  def noStock
    self.stock == 0
  end
end