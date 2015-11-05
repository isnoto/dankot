class Admin::MainPagePhotosController < AdminController
  before_action :find_photo, only: [:edit, :update, :destroy]

  def index
    @photos = MainPagePhoto.all
  end

  def show
  end

  def new
    @photo = MainPagePhoto.new
  end

  def edit
  end

  def create
    @photo = MainPagePhoto.new(photo_params)

    if @photo.save
      redirect_to main_page_photos_path
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to main_page_photos_path
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to main_page_photos_path
  end

  private

  def find_photo
    @photo = MainPagePhoto.find(params[:id])
  end

  def photo_params
    params.fetch(:main_page_photo, {}).permit(:image, :position)
  end
end
