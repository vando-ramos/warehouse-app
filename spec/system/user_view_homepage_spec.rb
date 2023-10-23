require 'rails_helper'

describe 'user visits homepage' do
  it "and sees the application's name" do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Warehouses and Stock')
  end

  it 'and sees the registered warehouses' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Santos Dumont Avenue, 500' , cep: '22000000',
                      description: 'Airport warehouse')
                    
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                      address: 'Forgotten Avenue, 150', cep: '32000150',
                      description: 'Port warehouse')

    # Act
    visit(root_path)

    # Assert
    expect(page).not_to have_content("There aren't registered warehouses")
    expect(page).to have_content('Rio')
    expect(page).to have_content('Code: SDU')
    expect(page).to have_content('City: Rio de Janeiro')
    expect(page).to have_content('Area: 60000 m2')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Code: MCZ')
    expect(page).to have_content('City: Maceio')
    expect(page).to have_content('Area: 50000 m2')
  end

  it "and there aren't registered warehouses" do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content("There aren't registered warehouses")
  end
end