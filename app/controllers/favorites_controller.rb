class FavoritesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def add_to_favorite
    @item = FavoriteItem.new(product_id: params[:id], favorite_id: current_user.favorite.id)
    if @item.save
      flash[:success] = "It has been added to your favorite!"
      redirect_to product_path(params[:id])
    else
      flash[:danger] = "It is already in your favorite!"
      redirect_to product_path(params[:id])
    end
  end
end
