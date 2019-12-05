module UsersHelper
  def logged_in_user
    unless logged_in?
      flash[:danger] = "请先登录。"
      redirect_to(login_url)
    end
  end

  def correct_user
    @user = User.all.find_by(id:params[:id])
    if @user.nil?
      @user = User.all.find_by(id:params[:user_id])
    end
    if @user != current_user and current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def correct_buyer
    if current_user.character != 'buyer' and current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def correct_user_buyer
    @user = User.all.find_by(id:params[:id])
    if @user.nil?
      @user = User.all.find_by(id:params[:user_id])
    end
    if !(@user == current_user and current_user.character == 'buyer') and current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def correct_seller
    if current_user.character != 'seller' and current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def correct_user_seller
    @user = User.all.find_by(id:params[:id])
    if @user.nil?
      @user = User.all.find_by(id:params[:user_id])
    end
    if !(@user == current_user and current_user.character == 'seller') and current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def correct_user_admin
    if current_user.character != 'administrator'
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  def product_current_user?
    @cur_product = Product.all.find_by(id:params[:product_id])
    if not @cur_product.nil? and @cur_product.shop.user.id == current_user.id
    else
      flash[:danger] = "抱歉，您没有访问此页面的权限，您的访问请求被拒绝。"
      redirect_to(root_url)
    end
  end

  # 返回指定用户的 Gravatar
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
