class StaticPagesController < ApplicationController
  def home
    @photos = MainPagePhoto.all
  end

  def portfolio
    @photos = PortfolioPhoto.all
  end

  def price
  end

  def about
  end

  def contacts
  end
end
