class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: %i[edit show update]
  before_action :check_user, only: %i[edit show update]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
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
  end

  def search
    @code = params['query']
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order), notice: 'Order updated successfully!'
    else
      flash.now.alert = 'Unable to update the order!'
      render 'edit'
    end
  end

  private

  def set_params
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :expected_delivery_date)
  end

  def check_user
    if @order.user != current_user
      return redirect_to root_path, alert: "You don't have access to this order!"
    end
  end
end
