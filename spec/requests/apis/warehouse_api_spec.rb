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
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'fail if warehouse not found' do
      get "/api/v1/warehouses/9999"

      expect(response.status).to eq(404)
    end
  end

  context 'GET/api/v1/warehouses' do
    it 'successfully' do
      Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                        address: 'Av do Aeroporto, 1000', cep: '15000-000',
                        description: 'Warehouse for international cargo')

      Warehouse.create!(name: 'Porto Santos', code: 'STO', city: 'Santos', area: 300_000,
                        address: 'Av Rei Pele, 1000', cep: '99900-990',
                        description: 'Porto de Santos')

      get '/api/v1/warehouses'

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response[0]['name']).to eq('Aeroporto SP')
      expect(json_response[1]['name']).to eq('Porto Santos')
    end

    it 'return empty if there is no warehouse' do
      get '/api/v1/warehouses'

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end

    it 'and raise an internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response).to have_http_status(500)
    end
  end

  context 'POST/api/v1/warehouses' do
    it 'successfully' do
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                          address: 'Av do Aeroporto, 1000', cep: '15000-000',
                          description: 'Destinado a cargas internacionais' } }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
      expect(json_response['city']).to eq('Guarulhos')
      expect(json_response['area']).to eq(100_000)
      expect(json_response['address']).to eq('Av do Aeroporto, 1000')
      expect(json_response['cep']).to eq('15000-000')
      expect(json_response['description']).to eq('Destinado a cargas internacionais')
    end

    it 'fail if parameters are not complete' do
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU' } }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(412)
      expect(response.body).not_to include("Name can't be blank")
      expect(response.body).not_to include("Code can't be blank")
      expect(response.body).to include("City can't be blank")
      expect(response.body).to include("Area can't be blank")
      expect(response.body).to include("Address can't be blank")
      expect(response.body).to include("Cep can't be blank")
      expect(response.body).to include("Description can't be blank")
    end

    it 'fails if there is an internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                          address: 'Av do Aeroporto, 1000', cep: '15000-000',
                          description: 'Destinado a cargas internacionais' } }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(500)
    end
  end
end
