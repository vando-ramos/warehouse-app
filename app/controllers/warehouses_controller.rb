class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show
    @stocks = @warehouse.stock_products.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: 'Warehouse registered successfully!'
    else
      flash.now.notice = 'Unregistered warehouse!'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse), notice: 'Warehouse updated successfully!'
    else
      flash.now.notice = 'Unable to update the warehouse!'
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: 'Warehouse deleted successfully!'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end
end
