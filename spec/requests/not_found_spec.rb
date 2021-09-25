require 'rails_helper'

RSpec.describe 'NotFound Route', type: :request do
  describe 'GET /index' do
    it 'return 404 is route isnt found' do
      get '/unknown'
      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body['error']).to eq('Not Found')
    end
  end
end
