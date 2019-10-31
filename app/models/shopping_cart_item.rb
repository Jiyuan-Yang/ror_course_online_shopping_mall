class ShoppingCartItem < ApplicationRecord
  validate :local_unique_validation

  belongs_to :shopping_cart
  belongs_to :product

  private

  def local_unique_validation
    @cart = ShoppingCart.find(shopping_cart_id)
    judge = 0
    @cart.shopping_cart_items.each do |item|
      if item.product_id == product_id and item.id != id
        judge = 1
      end
    end
    if judge == 1
      errors[:product_id] << 'It is already in your shopping cart'
    end
  end
end
