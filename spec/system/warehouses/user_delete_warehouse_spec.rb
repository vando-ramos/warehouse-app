require 'rails_helper'

describe 'User deletes a warehouse' do
  it 'successfully' do
    # Arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Av do Aeroporto, 1000', cep: '15000-000',
                      description: 'Warehouse for international cargo')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Delete'

    # Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Warehouse deleted successfully')
    expect(page).not_to have_content('Aeroporto SP')
    expect(page).not_to have_content('GRU')
    expect(page).not_to have_content('Guarulhos')
  end

  it 'and does not delete others warehouses' do
    # Arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Av do Aeroporto, 1000', cep: '15000-000',
                      description: 'Warehouse for international cargo')

    Warehouse.create!(name: 'Porto Santos', code: 'STO', city: 'Santos', area: 300_000,
                      address: ' Av Rei Pele, 5000', cep: '10010-100',
                      description: 'Warehouse port')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Delete'

    # Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Warehouse deleted successfully')
    expect(page).to have_content('Porto Santos')
    expect(page).not_to have_content('Aeroporto SP')
  end
end