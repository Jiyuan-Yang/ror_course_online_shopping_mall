class ShoppingCartsController < ApplicationController
  before_action :logged_in_user, only: [:show, :add_to_shopping_cart]
  before_action :correct_user_buyer, only: [:show]
  before_action :correct_buyer, only: [:add_to_shopping_cart]
  # we ensure that current user could add to sc only for himself

  def show
    @user = User.find(params[:id])
    @shopping_cart_items = @user.shopping_cart.shopping_cart_items.paginate(:page => params[:page], :per_page => 6)
  end

  def add_to_shopping_cart
    @item = ShoppingCartItem.new(amount: 1, shopping_cart_id: current_user.shopping_cart.id,
                         product_id: params[:id])
    if @item.save
      flash[:success] = "It has been added to your shopping cart!"
      redirect_to product_path(params[:id])
    else
      flash[:danger] = "It's already in your shopping cart!"
      redirect_to product_path(params[:id])
    end
  end
end
