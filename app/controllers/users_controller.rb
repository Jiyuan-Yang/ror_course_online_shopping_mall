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
      flash[:success] = "Welcome to the Max Jim's"
      redirect_to @user   # equals to `redirect_to user_url(@user)`
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :character, :password,
                                 :password_confirmation)
  end
end
