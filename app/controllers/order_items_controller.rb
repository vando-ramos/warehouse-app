class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[new create]

  def new
    @products = @order.supplier.product_models

    @order_item = OrderItem.new
  end

  def create
    @order.order_items.create(order_item_params)

    redirect_to order_path(@order), notice: 'Item added successfully!'
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end
end
