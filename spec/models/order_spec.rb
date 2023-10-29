require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      # Arrange
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2023-12-10')

      # Act
      result = order.valid?

      # Assert
      expect(result).to be(true)
    end
  end

  describe 'Generate a random code' do
    it 'when creating a new order' do
      # Arrange
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2023-12-10')

      # Act
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq(8)
    end

    it 'and the code is unique' do
      # Arrange
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2023-12-10')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, expected_delivery_date: '2023-12-18')

      # Act
      second_order.save!

      # Assert
      expect(second_order.code).not_to eq(first_order.code)
    end
  end
end
