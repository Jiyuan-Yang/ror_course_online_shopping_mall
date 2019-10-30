class ShoppingCartsController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def add_to_shopping_cart
    ShoppingCartItem.new(amount: 1, shopping_cart_id: current_user.shopping_cart.id,
                         product_id: params[:id]).save
  end
end
