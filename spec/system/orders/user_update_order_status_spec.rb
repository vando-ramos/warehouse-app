require 'rails_helper'

describe 'User updates order status' do
  it 'and the order was delivered' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    product = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'CP-SAM-321', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          expected_delivery_date: 1.day.from_now, status: 'pending')

    OrderItem.create!(order: order, product_model: product, quantity: 10)

    # Act
    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code
    click_on 'Mark as delivered'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Status: delivered')
    expect(page).not_to have_content('Mark as canceled')
    expect(page).not_to have_content('Mark as delivered')
    expect(StockProduct.count).to eq(10)
    stock = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(stock).to eq(10)
  end

  it 'and the order was canceled' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    product = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'CP-SAM-321', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          expected_delivery_date: 1.day.from_now, status: 'pending')

    OrderItem.create!(order: order, product_model: product, quantity: 10)

    # Act
    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code
    click_on 'Mark as canceled'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Status: canceled')
    expect(StockProduct.count).to eq(0)
  end
end
