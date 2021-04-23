class Product < ApplicationRecord
  validates :name, :price, :scheduled_start, :scheduled_end, presence: true
  
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :delete_all

  scope :owned_by, -> (user_id) {where user_id: user_id}
  scope :no_price, -> { where("price IS NULL") }
  scope :order_by_schedueldstart, -> (column = 'scheduled_start',ordered) { order("#{column} #{ordered}") if ordered}
  scope :search_keyword , -> (params) { params["q"].nil? ? Product.ransack(name_cont: params["q"]) : Product.ransack(name_cont: params["q"]["keyword_eq"], product_resolve_eq: Product.product_resolves[params["q"]["keyword_eq"]], m: 'or') }

  enum product_resolve: {不需叫貨: 0,  已叫貨: 1, 需叫貨: 2}

  ransack_alias :keyword, :name_or_product_resolve

  def noStock
    self.stock == 0
  end

  def stock_state
    if self.stock == 0
      return "empty"
    elsif self.stock > 0 && self.stock < 15
      return "less"
    else
      return "full"
    end
  end

  def all_tags
    tags.map{|tag| tag.name}.join(',')
  end

  def all_tags=(tags)
    self.tags = tags.split(',').map do |name|
                  Tag.where(name: name.strip).first_or_create
                end
  end
end