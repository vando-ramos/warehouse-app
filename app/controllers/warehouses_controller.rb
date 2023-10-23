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
    
    if @warehouse.save!()
      redirect_to root_path, notice: 'Warehouse registered successfully!'
    else
      flash.now.notice = 'Unregistered warehouse!'
      render 'new'
    end    
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])

    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)

    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse), notice: 'Warehouse updated successfully'
    else
      flash.now.notice = 'Unable to update the warehouse!'
      render 'edit'
    end
  end
end