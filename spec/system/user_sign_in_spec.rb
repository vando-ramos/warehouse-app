require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange
    User.create!(email: 'user@user.com', password: 'password')

    # Act
    visit root_path
    click_on 'Sign in'
    within('form') do
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Password', with: 'password'
      click_on 'Sign in'
    end

    # Assert
    expect(page).not_to have_link('Sign in')
    expect(page).to have_link('Sign out')
    within('nav') do
      expect(page).to have_content('user@user.com')
    end
    expect(page).to have_content('Signed in successfully')
  end
end
