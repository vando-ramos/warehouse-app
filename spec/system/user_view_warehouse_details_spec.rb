require 'rails_helper'

describe 'User sees details of a warehouse' do 
  it 'and sees additional information' do
    # Arrange
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                    description: 'Warehouse for international cargo')

    # Act
    visit(root_path)
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Code: GRU')
    expect(page).to have_content('City: Guarulhos')
    expect(page).to have_content('Area: 100000 m2')
    expect(page).to have_content('Address: Av do Aeroporto, 1000')
    expect(page).to have_content('CEP: 15000-000')
    expect(page).to have_content('Description: Warehouse for international cargo')
  end

  it 'and return to homepage' do 
    # Arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                    description: 'Warehouse for international cargo')
    w.save() # 'm = Model.new + m.save' is the same as 'Model.create'

    # Act
    visit(root_path)
    click_on 'Aeroporto SP'
    click_on 'Go Back'

    # Assert
    expect(current_path).to eq(root_path)
  end
end