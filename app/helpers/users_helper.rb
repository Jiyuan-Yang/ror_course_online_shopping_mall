module UsersHelper
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to(login_url)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if @user != current_user and current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end

  def correct_buyer
    if current_user.character != 'buyer' and current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end

  def correct_user_buyer
    @user = User.find(params[:id])
    if !(@user == current_user and current_user.character == 'buyer') and current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end

  def correct_seller
    if current_user.character != 'seller' and current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end

  def correct_user_seller
    @user = User.find(params[:id])
    if !(@user == current_user and current_user.character == 'seller') and current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end

  def correct_user_admin
    if current_user.character != 'administrator'
      flash[:danger] = "You have no right to do this"
      redirect_to(root_url)
    end
  end
end
