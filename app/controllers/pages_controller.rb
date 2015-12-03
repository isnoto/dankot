class PagesController < ApplicationController
  def home
    @photos = MainPagePhoto.all
  end

  def services
    @services = Service.all
  end

  def about
  end
end
