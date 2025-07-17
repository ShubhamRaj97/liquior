class Admin::StoresController < AdminController

  def index
    store = Store.all
    render json: {data: store} , status: :ok
  end


  def create
    store = Store.new(store_params)
    if store.save
        render json: {data: store}, status: :ok
    else
         render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def store_params
    params.require(:store).permit(:name, :address, :city, :state, :zip_code, :phone, :email, :active)
  end
end
