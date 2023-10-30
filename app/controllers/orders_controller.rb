class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(orders_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Order registered successfully!'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now.alert = 'Unable to register order'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params['query']
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  private

  def orders_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date)
  end
end
