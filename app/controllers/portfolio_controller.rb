class PortfolioController < ApplicationController
  def index
  end

  def photos
    @photos = PortfolioPhoto.all.where('category_id = ?', params[:id]).page(params[:page]).per(10)

    respond_to do |format|
      format.json { render json: @photos }
    end
  end

  private

  def last_page?
    @photos.total_pages == params[:page].to_i
  end
end
