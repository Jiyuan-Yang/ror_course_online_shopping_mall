class SessionsController < ApplicationController
  # deal with unexpected when log out in charts
  skip_before_action :verify_authenticity_token

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = '密码错误！'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
