class ShoppingCartsController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def add_to_shopping_cart
    ShoppingCartItem.new(amount: 1, shopping_cart_id: current_user.shopping_cart.id,
                         product_id: params[:id]).save
    flash[:success] = "it has been added to your shopping cart!"
    redirect_to(product_path(params[:id]))
  end
end
