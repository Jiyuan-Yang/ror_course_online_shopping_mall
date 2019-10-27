class FavoritesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def add_to_favorite
    FavoriteItem.new(product_id:params[:id],favorite_id:current_user.favorite.id).save
  end
end
