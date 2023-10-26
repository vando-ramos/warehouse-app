require 'rails_helper'

describe 'User sees suppliers' do
  it 'from menu' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Suppliers'
    end

    # Assert
    expect(current_path).to eq(suppliers_path)
  end

  it 'successfully' do
    # Arrange
    Supplier.create!(corporate_name: 'Duff ltda', brand_name: 'Duff', registration_number: '123456789',
                    address: 'Beers street, 51', city: 'Springfield', state: 'OR', email: 'duff@duff.com')

    Supplier.create!(corporate_name: 'Umbrella Corporation', brand_name: 'Mr-x', registration_number: '987654321',
                    address: 'Raccoon Avenue, 900', city: 'Raccoon', state: 'CA', email: 'umbrella@umbrella.com')
    # Act
    visit root_path
    click_on 'Suppliers'

    # Assert
    expect(page).to have_content('Suppliers')
    expect(page).to have_content('Duff')
    expect(page).to have_content('Springfield - OR')
    expect(page).to have_content('Mr-x')
    expect(page).to have_content('Raccoon - CA')
    expect(page).to have_content('Suppliers')
  end

  it "and there aren't registered suppliers" do
    # Arrange

    # Act
    visit root_path
    click_on 'Suppliers'

    # Assert
    expect(page).to have_content("There aren't registered suppliers")
  end
end
