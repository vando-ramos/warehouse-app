require 'rails_helper'

describe 'User register a supplier' do
  it 'from the index' do
    # Arrange

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Register Supplier'

    # Assert
    expect(page).to have_content('Corporate Name')
    expect(page).to have_content('Brand Name')
    expect(page).to have_content('NIF')
    expect(page).to have_content('Address')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Email')
  end

  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Register Supplier'
    fill_in 'Corporate Name', with: 'ACME Corporation'
    fill_in 'Brand Name', with: 'ACME'
    fill_in 'NIF', with: '123456123'
    fill_in 'Address', with: 'Warner Blvd, 4000'
    fill_in 'City', with: 'Los Angeles'
    fill_in 'State', with: 'CA'
    fill_in 'Email', with: 'acme@acme.com'
    click_on 'Send'

    # Assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Supplier registered successfully')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Los Angeles - CA')
  end

  it 'with incomplete data' do
    # Arrange

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Register Supplier'
    fill_in 'Corporate Name', with: ''
    fill_in 'Brand Name', with: ''
    fill_in 'NIF', with: ''
    click_on 'Send'

    # Assert
    expect(page).to have_content('Unregistered supplier')
    expect(page).to have_content("Corporate name can't be blank")
    expect(page).to have_content("Brand name can't be blank")
    expect(page).to have_content("Nif can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Email can't be blank")
  end
end
