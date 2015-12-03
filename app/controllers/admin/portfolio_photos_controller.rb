class Admin::PortfolioPhotosController < Admin::BaseController
  before_action :find_photo, only: [:edit, :update, :destroy]

  def index
    @photos = PortfolioPhoto.all
  end

  def show
  end

  def new
    @photo = PortfolioPhoto.new
  end

  def edit
  end

  def create
    @photo = PortfolioPhoto.new(photo_params)

    if @photo.save
      redirect_to admin_portfolio_photos_path, notice: "Фотография добавлена"
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to admin_portfolio_photos_path, notice: "Фотография обновлена"
    else
      render :new
    end
  end

  def destroy
    @photo.destroy
    redirect_to admin_portfolio_photos_path, notice: "Фотография удалена"
  end

  private

  def find_photo
    @photo = PortfolioPhoto.find(params[:id])
  end

  def photo_params
    params.fetch(:portfolio_photo, {}).permit(:image, :category_id)
  end
end
