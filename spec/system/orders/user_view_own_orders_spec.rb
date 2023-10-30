require 'rails_helper'

describe 'User sees own orders' do
  it 'and must be athenticated' do
    # Arrange

    # Act
    visit root_path
    click_on 'My Orders'

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it "and don't see other orders" do
    # Arrange
    user1 = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')
    user2 = User.create!(name: 'Fran', email: 'fran@email.com', password: '654321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order1 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)
    order2 = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)
    order3 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user1)
    visit root_path
    click_on 'My Orders'

    # Assert
    expect(page).to have_content(order1.code)
    expect(page).not_to have_content(order2.code)
    expect(page).to have_content(order3.code)
  end

  it 'and visits an order' do
    # Arrange
    user = User.create!(name: 'Fran', email: 'fran@email.com', password: '654321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code

    # Assert
    expect(page).to have_content('Order Details')
    expect(page).to have_content(order.code)
    expect(page).to have_content('Destination Warehouse: GRU - Aeroporto SP')
    expect(page).to have_content('Supplier: Samsung ltda')
    date_format = 1.day.from_now.to_date
    expect(page).to have_content("Expected Delivery Date: #{date_format}")
  end

  it "and doesn't visit orders from other users" do
    # Arrange
    user1 = User.create!(name: 'Fran', email: 'fran@email.com', password: '654321')
    user2 = User.create!(name: 'Bob', email: 'bob@email.com', password: '121212')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user2)
    visit order_path(order.id)

    # Assert
    expect(current_path).not_to eq(order_path(order.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have access to this order")
  end
end
