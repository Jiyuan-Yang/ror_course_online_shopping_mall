class StaticPagesController < ApplicationController
  before_action :correct_user_admin, only: [:all_orders, :all_users, :all_shops]

  def home
  end

  def about
  end

  def contact
  end

  def help
  end

  def all_users

  end

  def all_shops

  end

  def all_orders

  end

  def invalid_get_handler
    flash[:danger] = "抱歉，您尝试对此地址发出GET请求，但是这是一个无效行为，您的访问请求被拒绝。"
    redirect_to(root_url)
  end
end
