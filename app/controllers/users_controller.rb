class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # deal with the POST request
    @user = User.new(user_params)
    if @user.save
      if @user.character == 'buyer'
        ShoppingCart.new(user_id: @user.id).save
        Favorite.new(user_id: @user.id).save
      end
      log_in @user
      flash[:success] = "Welcome to the Max Jim's"
      redirect_to @user # equals to `redirect_to user_url(@user)`
    else
      render 'new'
    end
  end

  def show_shops
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :character, :password,
                                 :password_confirmation)
  end
end
