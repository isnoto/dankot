class Admin::ServicesController < Admin::BaseController
  before_action :find_service, only: [:edit, :update, :destroy]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to admin_services_path, notice: "Услуга добавлена"
    else
      render :new
    end
  end

  def update
    if @service.update(service_params)
      redirect_to admin_services_path, notice: "Услуга обновленна"
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path, notice: "Услуга удалена"
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description, :value)
  end
end
