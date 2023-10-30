require 'rails_helper'

describe 'User searches for an order' do
  it 'from menu' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('header nav') do
      expect(page).to have_field('Search Order')
      expect(page).to have_button('Search')
    end
  end

  it 'and must be authenticated' do
    # Arrange

    # Act
    visit root_path

    # Assert
    within('header nav') do
      expect(page).not_to have_field('Search Order')
      expect(page).not_to have_button('Search')
    end
  end

  it 'and searches an order' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

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
    fill_in 'Search Order', with: order.code
    click_on 'Search'

    # Assert
    expect(page).to have_content("Search results for: #{order.code}")
    expect(page).to have_content('1 order found')
    expect(page).to have_content("Code: #{order.code}")
    expect(page).to have_content('Destination warehouse: GRU - Aeroporto SP')
    expect(page).to have_content('Supplier: Samsung ltda')
  end

  it 'and finds multiple orders' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    warehouse2 = Warehouse.create!(name: 'Porto Santos', code: 'STO', city: 'Santos', area: 300_000,
                                  address: 'Av Rei Pele, 1000', cep: '99900-990',
                                  description: 'Porto de Santos')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU12345')
    order1 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, expected_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU54321')
    order2 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, expected_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).and_return('STO12345')
    order3 = Order.create!(user: user, warehouse: warehouse2, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Search Order', with: 'GRU'
    click_on 'Search'

    # Assert
    expect(page).to have_content('2 orders found')
    expect(page).to have_content('GRU12345')
    expect(page).to have_content('GRU54321')
    expect(page).to have_content('Destination warehouse: GRU - Aeroporto SP')
    expect(page).not_to have_content('STO12345')
    expect(page).not_to have_content('Destination warehouse: STO - Porto Santos')
  end
end
