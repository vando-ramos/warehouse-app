require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Generates a serial number' do
    it 'when creating a product in stock' do
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                            expected_delivery_date: 1.week.from_now, status: :delivered)

      product = ProductModel.create!(name: 'Galaxy', weight: '100', width: '6', height: '12',
                                      depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq(20)
    end

    it 'and must not be modified' do
      user = User.create!(name: 'Dino', email: 'dino@email.com', password: '123456')

      warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      warehouse2 = Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 30_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15015-150',
                                    description: 'Santos Dumont')

      supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                  registration_number: '123456789', address: 'Samsung Street, 100',
                                  city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

      order = Order.create!(user: user, warehouse: warehouse1, supplier: supplier,
                            expected_delivery_date: 1.week.from_now, status: :delivered)

      product = ProductModel.create!(name: 'Galaxy', weight: '100', width: '6', height: '12',
                                      depth: '2', sku: 'CP-SAM-321', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse1, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: warehouse2)

      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end
