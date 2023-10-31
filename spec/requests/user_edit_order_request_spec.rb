require 'rails_helper'

describe 'User edits an order' do
  it "and isn't responsible for it" do
    # Arrange
    user1 = User.create!(name: 'Bob', email: 'bob@email.com', password: '121212')
    user2 = User.create!(name: 'Fran', email: 'fran@email.com', password: '321321')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Warehouse for international cargo')

    supplier = Supplier.create!(corporate_name: 'Samsung ltda', brand_name: 'Samsung',
                                registration_number: '123456789', address: 'Samsung Street, 100',
                                city: 'Samsung City', state: 'SC', email: 'samsung@samsung.com')

    order = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, expected_delivery_date: 1.day.from_now)

    # Act
    login_as(user1)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    # Assert
    expect(response).to redirect_to(root_path)
  end
end
