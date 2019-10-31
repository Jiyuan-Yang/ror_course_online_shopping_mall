class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
      if @user.character == "buyer"
        ShoppingCart.new(user_id: @user.id).save
        Favorite.new(user_id: @user.id).save
      end

      log_in(@user)
      flash[:success] = "Welcome to the Max Jim's"
      redirect_to(@user)
    else
      render("new")
    end
  end

  def show_shops
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Edit Successfully!"
      redirect_to(@user)
    else
      render("edit")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :character, :password, :password_confirmation, :receiver_name, :receiver_address, :receiver_phone_number)

  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to(login_url)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
