require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'UNT', city: 'Test', area: 1,
                                  address: 'Unit test, 1', cep: '15000-000', description: 'Unit test')

        # Act
        # result = warehouse.valid?

        # Assert
        # expect(result).to eq false
        expect(warehouse).not_to be_valid
      end
    end

    it 'false when code is already in use' do
      # Arrange
      first_warehouse = Warehouse.create(name: 'Unit', code: 'UNT', city: 'Unit', area: 1,
                                          address: 'Unit, 1', cep: '15000-000', description: 'Unit')

      second_warehouse = Warehouse.create(name: 'Test', code: 'UNT', city: 'Test', area: 2,
                                          address: 'Test, 2', cep: '25000-000', description: 'Test')

      # Act
      # result = second_warehouse.valid?

      # Assert
      # expect(result).to eq false
      expect(second_warehouse).not_to be_valid
    end
  end
end
