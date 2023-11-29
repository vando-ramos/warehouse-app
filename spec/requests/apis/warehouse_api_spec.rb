require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouses/1' do
    it 'successfully' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Av do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Warehouse for international cargo')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')

      json_response = JSON.parse(response.body)

      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
    end

    it 'fail' do

    end
  end
end
