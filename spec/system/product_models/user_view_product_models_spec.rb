require 'rails_helper'

describe 'User sees product models' do
  it 'if authenticated' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Product Models'
    end

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'from menu' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Product Models'
    end

    # Assert
    expect(current_path).to eq(product_models_path)
  end

  it 'successfully' do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    ProductModel.create!(name: 'Cellphone', weight: '100', width: '6', height: '12',
                        depth: '2', sku: 'CP-SAM-321', supplier: supplier)

    ProductModel.create!(name: 'Notebook', weight: '1000', width: '50', height: '30',
                        depth: '20', sku: 'NB-SAM-123', supplier: supplier)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Product Models'
    end

    # Assert
    expect(page).to have_content('Cellphone')
    expect(page).to have_content('CP-SAM-321')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('Notebook')
    expect(page).to have_content('NB-SAM-123')
    expect(page).to have_content('Samsung')
  end

  it "and there aren't registered product models" do
    # Arrange
    user = User.create!(name: 'User', email: 'user@email.com', password: '123456')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Product Models'
    end

    # Assert
    expect(page).to have_content("There aren't registered product models")
  end
end
