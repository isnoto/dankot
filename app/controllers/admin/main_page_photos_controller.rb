class Admin::MainPagePhotosController < Admin::BaseController
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
      redirect_to admin_main_page_photos_path, notice: "Фотография добавлена"
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to admin_main_page_photos_path, notice: "Фотография обновлена"
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to admin_main_page_photos_path, notice: "Фотография удалена"
  end

  private

  def find_photo
    @photo = MainPagePhoto.find(params[:id])
  end

  def photo_params
    params.fetch(:main_page_photo, {}).permit(:image, :position)
  end
end
