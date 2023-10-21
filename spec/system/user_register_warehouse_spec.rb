require 'rails_helper'

describe 'User register a warehouse' do
  it 'from the homepage' do
    # Arrange

    # Act
    visit root_path
    click_on 'Register Warehouse'

    # Assert
    expect(page).to have_field('Name')
    expect(page).to have_field('Code')
    expect(page).to have_field('City')
    expect(page).to have_field('Area')
    expect(page).to have_field('Address')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Description')
  end

  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Register Warehouse'
    fill_in 'Name', with: 'Rio de Janeiro'
    fill_in 'Code', with: 'RIO'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'Area', with: '50000'
    fill_in 'Address', with: 'Francisco Bicalho Avenue, 1000'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Description', with: 'Warehouse in the port area of ​​Rio'
    click_on 'Send'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RIO')
    expect(page).to have_content('50000 m2')
  end
end