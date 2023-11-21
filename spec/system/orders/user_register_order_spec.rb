require 'rails_helper'

describe 'User register an order' do
  it 'and must be authenticated' do
    # Arrange

    # Act
    visit root_path
    click_on 'Register Order'

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    Warehouse.create!(name: 'Porto Santos', code: 'STO', city: 'Santos', area: 300_000,
                      address: ' Av Rei Pele, 5000', cep: '10010-100',
                      description: 'Warehouse port')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '987654321',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCD1234')

    # Act
    login_as(user)
    visit root_path
    click_on 'Register Order'
    select 'GRU - Aeroporto SP', from: 'Destination Warehouse'
    select supplier.corporate_name, from: 'Supplier'
    fill_in 'Expected Delivery Date', with: '2023-12-15'
    click_on 'Save'

    # Assert
    expect(page).to have_content('Order registered successfully')
    expect(page).to have_content('Order ABCD1234')
    expect(page).to have_content('Destination Warehouse: GRU - Aeroporto SP')
    expect(page).to have_content('Supplier: Samsung ltda')
    expect(page).to have_content('Responsible User: Dino - dino@email.com')
    expect(page).to have_content('Expected Delivery Date: 2023-12-15')
    expect(page).to have_content('Status: pending')
    expect(page).not_to have_content('Porto Santos')
    expect(page).not_to have_content('Duff ltda')
  end

  it "and doesn't inform the delivery date" do
    # Arrange
    user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    # Act
    login_as(user)
    visit root_path
    click_on 'Register Order'
    select 'GRU - Aeroporto SP', from: 'Destination Warehouse'
    select supplier.corporate_name, from: 'Supplier'
    fill_in 'Expected Delivery Date', with: ''
    click_on 'Save'

    # Assert
    expect(page).to have_content('Unable to register order')
    expect(page).to have_content("Expected delivery date can't be blank")
  end
end
