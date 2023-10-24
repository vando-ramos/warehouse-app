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
end