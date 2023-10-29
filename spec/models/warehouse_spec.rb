require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'UNT', city: 'Test', area: 1,
                                  address: 'Unit test, 1', cep: '15000-000', description: 'Unit test')

        # Act

        # Assert
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

      # Assert
      expect(second_warehouse).not_to be_valid
    end
  end

  describe '#full_description' do
    it 'shows name and code' do
      # Arrange
      w = Warehouse.new(name: 'Rio Grande do Sul', code: 'RGS')

      # Act
      result = w.full_description()

      # Assert
      expect(result).to eq('RGS - Rio Grande do Sul')
    end
  end
end
