require 'rails_helper'

describe 'User edits a warehouse' do
  it 'from the details page' do
    # Arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Av do Aeroporto, 1000', cep: '15000-000',
                      description: 'Warehouse for international cargo')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Edit'

    # Assert
    expect(page).to have_content('Edit Warehouse')
    expect(page).to have_field('Name', with: 'Aeroporto SP')
    expect(page).to have_field('Code', with: 'GRU')
    expect(page).to have_field('City', with: 'Guarulhos')
    expect(page).to have_field('Area', with: '100000')
    expect(page).to have_field('Address', with: 'Av do Aeroporto, 1000')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Description', with: 'Warehouse for international cargo')
  end

  it 'successfully' do
    # Arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Av do Aeroporto, 1000', cep: '15000-000',
                      description: 'Warehouse for international cargo')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Edit'
    fill_in 'Name', with: 'Aeroporto RJ'
    fill_in 'Code', with: 'SDU'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'Area', with: '40000'
    fill_in 'Address', with: 'Airport Avenue, 100'
    fill_in 'CEP', with: '22020-020'
    fill_in 'Description', with: 'National airport'
    click_on 'Send'

    # Assert
    expect(page).to have_content('Aeroporto RJ')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('40000 m2')
    expect(page).to have_content('Airport Avenue, 100')
    expect(page).to have_content('22020-020')
    expect(page).to have_content('National airport')
    expect(page).to have_content('Warehouse updated successfully')
  end

  it 'and keeps the required fields' do
    # Arrange
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Av do Aeroporto, 1000', cep: '15000-000',
                      description: 'Warehouse for international cargo')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Edit'
    fill_in 'Name', with: ''
    fill_in 'Code', with: ''
    fill_in 'City', with: ''    
    click_on 'Send'

    # Assert
    expect(page).to have_content('Unable to update the warehouse')    
  end
end