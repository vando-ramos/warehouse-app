class Api::V1::WarehousesController < ActionController::API
  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: %i[created_at updated_at])
    rescue
      return render status: 404
    end
  end

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses
  end
end
