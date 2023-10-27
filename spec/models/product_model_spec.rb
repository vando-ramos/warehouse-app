require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'Name is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: '', weight: '100', width: '6', height: '12',
                            depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end

    it 'Weight is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: 'Cellphone', weight: '', width: '6', height: '12',
                            depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end

    it 'Width is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: 'Cellphone', weight: '100', width: '', height: '12',
                            depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end

    it 'Height is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: 'Cellphone', weight: '100', width: '6', height: '',
                            depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end

    it 'Depth is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: 'Cellphone', weight: '100', width: '6', height: '12',
                            depth: '', sku: 'CP-SAM-321', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end

    it 'SKU is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      pm = ProductModel.new(name: 'Cellphone', weight: '100', width: '6', height: '12',
                            depth: '2', sku: '', supplier: supplier)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq(false)
    end
  end
end
