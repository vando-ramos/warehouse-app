class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show]

  def index
    @suppliers = Supplier.all
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      redirect_to suppliers_path, notice: 'Supplier registered successfully!'
    else
      flash.now.notice = 'Unregistered supplier!'
      render 'new'
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :nif, :address, :city, :state, :email)
  end
end
