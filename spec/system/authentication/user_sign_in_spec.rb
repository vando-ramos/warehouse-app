require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange
    User.create!(name: 'Dino', email: 'dino@user.com', password: 'password')

    # Act
    visit root_path
    click_on 'Sign in'
    within('form') do
      fill_in 'Email', with: 'dino@user.com'
      fill_in 'Password', with: 'password'
      click_on 'Sign in'
    end

    # Assert
    expect(page).to have_content('Signed in successfully')
    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('Dino - dino@user.com')
    end

  end

  it 'and signs out' do
    # Arrange
    User.create!(email: 'dino@user.com', password: 'password')

    # Act
    visit root_path
    click_on 'Sign in'
    within('form') do
      fill_in 'Email', with: 'dino@user.com'
      fill_in 'Password', with: 'password'
      click_on 'Sign in'
    end
    click_on 'Sign out'

    # Assert
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Sign in')
    expect(page).not_to have_button('Sign out')
    within('nav') do
      expect(page).not_to have_content('dino@user.com')
    end
  end
end
