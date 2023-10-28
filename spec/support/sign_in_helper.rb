def sign_in(user)
  click_on 'Sign in'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within('form') do
    click_on 'Sign in'
  end
end
