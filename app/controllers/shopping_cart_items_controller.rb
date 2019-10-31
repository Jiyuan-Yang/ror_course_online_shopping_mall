class ShoppingCartItemsController < ApplicationController
  def item_amount_add
    @item = ShoppingCartItem.find(params[:cart_item_id])
    @item.update({amount: @item.amount + 1})
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end

  def item_amount_subtract
    @item = ShoppingCartItem.find(params[:cart_item_id])
    if @item.amount > 1
      @item.update(amount: @item.amount - 1)
    end
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end

  def destroy
    @item = ShoppingCartItem.find(params[:cart_item_id])
    name = Product.find(@item.product_id).name
    @item.destroy
    flash[:success] = "Shopping cart item #{name} deleted!"
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end
end
