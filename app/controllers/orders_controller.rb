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
    @order.save()
    redirect_to @order, notice: 'Order registered successfully!'
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def orders_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date)
  end
end
