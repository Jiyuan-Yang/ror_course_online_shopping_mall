class FavoriteItemsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def destroy
    @item = FavoriteItem.find(params[:favorite_item_id])
    name = Product.find(@item.product_id).name
    @item.destroy
    flash[:success] = "Favorite item #{name} deleted!"
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end
end
