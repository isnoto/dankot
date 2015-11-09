class SessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_to admin_path, notice: "Добро пожаловать"
    else
      flash.now[:alert] = "Вход не удался"
      render :new, layout: "admin"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
