require 'rails_helper'

describe 'user visits homepage' do
  it 'and sees the apps name' do
    visit('/')

    expect(page).to have_content('Warehouses and Stock')
  end
end