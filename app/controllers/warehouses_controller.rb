class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new  
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save()
      redirect_to root_path, notice: 'Warehouse registered successfully!'
    else
      flash.now.notice = 'Unregistered warehouse!'
      render 'new'
    end    
  end
end