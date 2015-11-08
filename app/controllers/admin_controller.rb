class AdminController < ApplicationController
  layout "admin"

  before_action :require_login

  def index
  end

  private

  def require_login
    unless logged_in?
      render "sessions/new"
    end
  end
end
