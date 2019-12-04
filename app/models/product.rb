class Product < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validate :local_unique_validation
  validates :description, presence: true, length: {minimum: 10, maximum: 100}

  # VALID_PRICE_REGEX = /\A\d+(\.\d{1,2})\z/
  validates :price, presence: true
  validates_numericality_of :price
  # use this to judge whether if it's a number

  CATEGORY = {'服装': 'clothes', '书籍': 'books', '办公用品': 'office', '电子产品': 'digital',
              '休闲娱乐': 'entertainment', '植物/动物': 'fruits_and_animals',
              '虚拟商品': 'virtual_items'}

  belongs_to :shop
  has_many :shopping_cart_items, dependent: :delete_all
  has_many :favorite_items, dependent: :delete_all
  has_many :order_items, dependent: :delete_all

  private

  def local_unique_validation
    cur_shop_products = Shop.find(shop_id).products
    judge = 0
    cur_shop_products.each do |item|
      # in order to deal with update
      if name == item.name and item.id != id
        judge = 1
      end
    end
    if judge == 1
      errors[:name] << 'Product name is already used in this shop'
    end
  end
end
