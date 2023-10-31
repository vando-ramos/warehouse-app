require 'rails_helper'

describe 'User edits an order' do
  it 'and must be authenticated' do
    # Arrange
    user = User.create!(name: 'Bob', email: 'bob@email.com', password: '121212')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    # arrange
    user = User.create!(name: 'Bob', email: 'bob@email.com', password: '121212')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '987654321',
                      address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'My Orders'
    click_on order.code
    click_on 'Edit'
    fill_in 'Expected Delivery Date', with: '2023-12-20'
    select 'Samsung ltda', from: 'Supplier'
    click_on 'Save'

    # Assert
    expect(page).to have_content('Order updated successfully')
    expect(page).to have_content('Supplier: Samsung ltda')
    expect(page).to have_content('Expected Delivery Date: 2023-12-20')
  end

  it 'if is responsible for it' do
    # Arrange
    user1 = User.create!(name: 'Bob', email: 'bob@email.com', password: '121212')
    user2 = User.create!(name: 'Fran', email: 'fran@email.com', password: '321321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user1)
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq(root_path)
  end
end
