class PortfolioController < ApplicationController
  def index
    @categories = Category.all
  end

  def photos
    @photos = get_photos.page(photos_params[:page]).per(10)

    respond_to do |format|
      format.json { render json: @photos }
    end
  end

  private

  def photos_params
    params.permit(:page, :category_id)
  end

  def last_page?
    @photos.total_pages == params[:page].to_i
  end

  def get_photos
    if photos_params[:category_id]
      PortfolioPhoto.where('category_id = ?', photos_params[:category_id])
    else
      PortfolioPhoto.all
    end
  end
end
