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


  def update
    store = Store.find_by(id: params[:id])

    if store.present?
      if store.update(store_params.except(:email))  # if you want to skip updating email
        render json: { data: store }, status: :ok
      else
        render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Store not found" }, status: :not_found
    end
  end

  def delete
    store = Store.find_by(id: params[:id])

    if store.present?
      if store.destroy  # if you want to skip updating email
        render json: { error: "Store deleted successfully" }, status: :ok
      else
        render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Store not found" }, status: :not_found
    end
  end
  


  private

  def store_params
    params.require(:store).permit(:name, :address, :city, :state, :zip_code, :phone, :email, :active)
  end
end
