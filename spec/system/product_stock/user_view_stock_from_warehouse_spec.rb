require 'rails_helper'

describe 'User sees the stock' do
  it 'on warehouse screen' do
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          expected_delivery_date: 1.day.from_now)

    product1 = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'A12345', supplier: supplier)

    product2 = ProductModel.create!(name: 'Produto B', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'B54321', supplier: supplier)

    product3 = ProductModel.create!(name: 'Produto C', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'C11223', supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product1) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product2) }

    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    within('section#stock-items') do
      expect(page).to have_content('Stock Items')
      expect(page).to have_content('3 x A12345')
      expect(page).to have_content('2 x B54321')
      expect(page).not_to have_content('C11223')
    end
  end

  it 'and one item is taken out of the stock' do
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          expected_delivery_date: 1.day.from_now)

    product = ProductModel.create!(name: 'Produto A', weight: '100', width: '6', height: '12',
                                  depth: '2', sku: 'A12345', supplier: supplier)

    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product) }

    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'A12345', from: 'Item Withdrawal'
    fill_in 'Recipient', with: 'Customer'
    fill_in 'Destination Address', with: 'Customer Street, 100 - São Paulo - SP'
    click_on 'Confirm Withdrawal'

    expect(current_path).to eq(warehouse_path(warehouse.id))
    expect(page).to have_content('Item successfully withdrawn')
    expect(page).to have_content('1 x A12345')
  end
end
