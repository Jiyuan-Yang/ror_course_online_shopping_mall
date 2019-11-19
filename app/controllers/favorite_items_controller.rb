class FavoriteItemsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def destroy
    @item = FavoriteItem.find(params[:favorite_item_id])
    name = Product.find(@item.product_id).name
    @item.destroy
    flash[:success] = "#{name}已经成功从您的收藏夹中删除！"
    redirect_to(user_shopping_cart_path(id: params[:id]))
  end
end
