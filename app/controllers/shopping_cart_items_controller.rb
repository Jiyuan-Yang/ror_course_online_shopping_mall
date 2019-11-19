class ShoppingCartItemsController < ApplicationController
  #before_action :logged_in_user, only: [:item_amount_add, :item_amount_subtract, :destroy]
  before_action :correct_user_buyer, only: [:item_amount_add, :item_amount_subtract, :destroy]

  def item_amount_add
    @item = ShoppingCartItem.find(params[:cart_item_id])
    @item.update!(amount: @item.amount + 1)
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end

  def item_amount_subtract
    @item = ShoppingCartItem.find(params[:cart_item_id])
    if @item.amount > 1
      @item.update!(amount: @item.amount - 1)
    end
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end

  def destroy
    @item = ShoppingCartItem.find(params[:cart_item_id])
    name = Product.find(@item.product_id).name
    @item.destroy
    flash[:success] = "#{name}已经从您的购物车中成功删除!"
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end
end
