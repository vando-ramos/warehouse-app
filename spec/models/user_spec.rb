require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'shows name and email' do
      # Arrange
      u = User.new(name: 'Dino', email: 'dino@sauro.com')

      # Act
      result = u.description()

      # Assert
      expect(result).to eq('Dino - dino@sauro.com')
    end
  end
end
