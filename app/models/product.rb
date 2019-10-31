class Product < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validate :partial_unique_validation
  validates :description, presence: true, length: {minimum: 10, maximum: 100}

  # VALID_PRICE_REGEX = /\A\d+(\.\d{1,2})\z/
  validates :price, presence: true
  validates_numericality_of :price
  # use this to judge whether if it's a number

  belongs_to :shop
  has_many :shopping_cart_items
  has_many :favorite_items
  has_many :order_items

  private
  def partial_unique_validation
    cur_shop_products = Shop.find(shop_id).products
    judge = 0
    cur_shop_products.each do |item|
      if name == item.name
        judge = 1
      end
    end
    if judge == 1
      errors[:name] << 'Product name is already used in this shop'
    end
  end
end
