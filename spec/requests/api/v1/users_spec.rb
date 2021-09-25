require 'rails_helper'

RSpec.describe 'Api::V1::Users#Show', type: :request do
  context 'Get User' do
    let(:headers) { generate_headers }
    let(:user) { create :user }
    let(:url) { api_v1_me_path }
    let(:no_headers_url) { get url }

    context 'Authenticate User' do
      it 'return 401 if token is not in headers' do
        no_headers_url
        expect(response.status).to eq(401)
      end

      it 'return 401 if uid is not in headers' do
        no_headers_url
        expect(response.status).to eq(401)
      end

      it 'return 401 if client is not in headers' do
        no_headers_url
        expect(response.status).to eq(401)
      end
    end

    context 'Valid Header' do
      it 'should return 200 if user exists' do
        get url, headers: headers
        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['errors']).to be nil
        expect(body.keys).to include('id', 'first_name', 'last_name', 'email', 'username', 'readings')
      end
    end
  end
end
