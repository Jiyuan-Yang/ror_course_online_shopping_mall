class UsersController < ApplicationController
  def show

  end

  def new
    @user = User.new
  end

  def create
    # deal with the POST request
    @user = User.new(user_params)
    if @user.save

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
