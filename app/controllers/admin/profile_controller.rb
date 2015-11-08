class Admin::ProfileController < AdminController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to admin_path, notice: "Профиль обновлен"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
