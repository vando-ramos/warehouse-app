require 'rails_helper'

describe 'User edits a supplier' do
  it 'from the details page' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Duff'
    click_on 'Edit'

    # Assert
    expect(page).to have_content('Edit Supplier')
    expect(page).to have_field('Corporate Name', with: 'Duff ltda')
    expect(page).to have_field('Brand Name', with: 'Duff')
    expect(page).to have_field('Registration Number', with: '123456789')
    expect(page).to have_field('Address', with: 'Beers street, 51')
    expect(page).to have_field('City', with: 'Springfield')
    expect(page).to have_field('State', with: 'OR')
    expect(page).to have_field('Email', with: 'duff@duff.com')
  end

  it 'successfully' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Duff'
    click_on 'Edit'
    fill_in 'Corporate Name', with: 'Duff ltda'
    fill_in 'Brand Name', with: 'Duff'
    fill_in 'Registration Number', with: '123456789'
    fill_in 'Address', with: 'Beers street, 51'
    fill_in 'City', with: 'Springfield'
    fill_in 'State', with: 'OR'
    fill_in 'Email', with: 'duff@duff.com'
    click_on 'Send'

    # Assert
    expect(page).to have_content('Duff ltda')
    expect(page).to have_content('Duff')
    expect(page).to have_content('123456789')
    expect(page).to have_content('Beers street, 51')
    expect(page).to have_content('Springfield')
    expect(page).to have_content('OR')
    expect(page).to have_content('duff@duff.com')
    expect(page).to have_content('Supplier updated successfully')
  end

  it 'and keeps the required fields' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Duff'
    click_on 'Edit'
    fill_in 'Corporate Name', with: ''
    fill_in 'Brand Name', with: ''
    fill_in 'Registration Number', with: ''
    click_on 'Send'

    # Assert
    expect(page).to have_content('Unable to update the supplier')
  end
end
