class ShopsController < ApplicationController
  def new
    @shop = Shop.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    # here could use user id because it's passed
    # but in `new` it couldn't be reached
  end

  def create
    # deal with the POST request
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = "Your shop \"#{shop_params[:name]}\" is ready!"
      redirect_to shop_url(current_user) # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description)
  end
end
