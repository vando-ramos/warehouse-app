require 'rails_helper'

describe 'User sees details of a supplier' do
  it 'from the supplier index' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Duff'

    # Assert
    expect(page).to have_content('Duff ltda')
    expect(page).to have_content('Duff')
    expect(page).to have_content('123456789')
    expect(page).to have_content('Beers street, 51')
    expect(page).to have_content('Springfield')
    expect(page).to have_content('OR')
    expect(page).to have_content('duff@duff.com')
  end

  it 'and return to homepage' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    # Act
    visit root_path
    click_on 'Suppliers'
    click_on 'Duff'
    click_on 'Home'

    # Assert
    expect(current_path).to eq(root_path)
  end
end
