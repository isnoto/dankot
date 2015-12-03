class PagesController < ApplicationController
  def home
    @photos = MainPagePhoto.all
  end

  def price
    @services = Service.all
  end

  def about
  end
end
