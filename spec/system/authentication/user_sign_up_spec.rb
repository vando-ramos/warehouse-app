require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Sign in'
    click_on 'Sign up'
    fill_in 'Name', with: 'Name'
    fill_in 'Email', with: 'name@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    # Assert
    expect(page).to have_content('name@email.com')
    expect(page).to have_button('Sign out')
    expect(page).to have_content('Welcome! You have signed up successfully')
    user = User.last
    expect(user.name).to eq('Name')
  end
end
