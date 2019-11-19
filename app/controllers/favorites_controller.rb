class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:show, :add_to_favorite]
  before_action :correct_user, only: [:show]
  before_action :correct_buyer, only: [:add_to_favorite]

  def show
    @user = User.find(params[:id])
    @favorite_items = @user.favorite.favorite_items.paginate(:page => params[:page], :per_page => 8)
  end

  def add_to_favorite
    @item = FavoriteItem.new(product_id: params[:id], favorite_id: current_user.favorite.id)
    if @item.save
      flash[:success] = "成功添加商品到收藏夹中!"
      redirect_to product_path(params[:id])
    else
      flash[:danger] = "该商品已经在您的收藏夹中!"
      redirect_to product_path(params[:id])
    end
  end
end
