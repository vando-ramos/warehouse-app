require 'rails_helper'

describe 'User register a product model' do
  it 'successfully' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    # Act
    visit root_path
    click_on 'Product Models'
    click_on 'Register Product Model'
    fill_in 'Name', with: 'Cellphone'
    fill_in 'Weight', with: '100'
    fill_in 'Width', with: '6'
    fill_in 'Height', with: '12'
    fill_in 'Depth', with: '2'
    fill_in 'SKU', with: 'CP-SAM-321'
    select 'Samsung', from: 'Supplier'
    click_on 'Send'

    # Assert
    expect(page).to have_content('Product model registered successfully')
    expect(page).to have_content('Cellphone')
    expect(page).to have_content('Weight: 100g')
    expect(page).to have_content('Dimension: 6cm x 12cm x 2cm')
    expect(page).to have_content('SKU: CP-SAM-321')
    expect(page).to have_content('Supplier: Samsung')
  end
end
