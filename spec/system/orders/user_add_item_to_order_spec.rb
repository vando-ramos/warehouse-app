require 'rails_helper'

describe 'User add items to order' do
  it 'successfully' do
    user = User.create!(name: 'Fran', email: 'fran@email.com', password: '654321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    pm1 = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                        depth: '2', sku: 'CP-SAM-321', supplier: supplier)
    pm2 = ProductModel.create!(name: 'Produto B', weight: '100', width: '6', height: '12',
                        depth: '2', sku: 'CP-SAM-321', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code
    click_on 'Add Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantity', with: '20'
    click_on 'Save'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Item added successfully')
    expect(page).to have_content('20x Produto A')
  end

  it "and doesn't see products from another supplier" do
    user = User.create!(name: 'Fran', email: 'fran@email.com', password: '654321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier1 = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    supplier2 = Supplier.create!(corporate_name: 'LG ltda', brand_name: 'LG',
                                registration_number: '111222333', address: 'Lg Street, 100',
                                city: 'Lg City', state: 'LG', email: 'lg@lg.com')

    pm1 = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                        depth: '2', sku: 'CP-SAM-321', supplier: supplier1)
    pm2 = ProductModel.create!(name: 'Produto B', weight: '100', width: '6', height: '12',
                        depth: '2', sku: 'CP-SAM-321', supplier: supplier2)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier1, expected_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code
    click_on 'Add Item'

    expect(page).to have_content('Produto A')
    expect(page).not_to have_content('Produto B')
  end
end
