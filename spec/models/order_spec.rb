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

    it 'expected delivery date must be mandatory' do
      # Arrange
      order = Order.new(expected_delivery_date: '')

      # Act
      order.valid?
      result = order.errors.include?(:expected_delivery_date)

      # Assert
      expect(result).to be(true)
    end

    it 'expected delivery date must be a future date' do
      # Arrange
      order = Order.new(expected_delivery_date: 1.day.ago)

      # Act
      order.valid?
      result = order.errors.include?(:expected_delivery_date)

      # Assert
      expect(result).to be(true)
      expect(order.errors[:expected_delivery_date]).to include('date must be in the future')
    end

    it "expected delivery date can't be the same as today" do
      # Arrange
      order = Order.new(expected_delivery_date: Date.today)

      # Act
      order.valid?
      result = order.errors.include?(:expected_delivery_date)

      # Assert
      expect(result).to be(true)
      expect(order.errors[:expected_delivery_date]).to include('date must be in the future')
    end

    it "expected delivery date must be equal to or greater than tomorrow" do
      # Arrange
      order = Order.new(expected_delivery_date: 1.day.from_now)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:expected_delivery_date)).to be(false)
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

    it 'and must not be modified' do
      # Arrange
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                            expected_delivery_date: 1.week.from_now)

      original_code = order.code

      # Act
      order.update!(expected_delivery_date: 1.month.from_now)

      # Assert
      expect(order.code).to eq(original_code)
    end
  end
end
