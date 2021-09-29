require 'rails_helper'

RSpec.describe 'Api::V1::Readings', type: :request do
  context 'Create' do
    params = nil
    let(:user) { create :user }
    let(:readings_url) { api_v1_readings_path }
    let(:headers) { generate_headers(user) }
    before(:each) do
      params = {
        fasting: 90.00,
        after_meal: 130.43,
        date: Time.now + 600,
        bp: 180.00
      }
    end

    it 'should validate presence of fasting' do
      params[:fasting] = nil
      post_request(readings_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('fasting')
      expect(json['errors']['fasting']).to include("can't be blank")
    end

    it 'should validate presence of after meal ' do
      params[:after_meal] = nil
      post_request(readings_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('after_meal')
      expect(json['errors']['after_meal']).to include("can't be blank")
    end

    it 'should validate presence of bp' do
      params[:bp] = nil
      post_request(readings_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('bp')
      expect(json['errors']['bp']).to include("can't be blank")
    end

    it 'should validate presence of date' do
      params[:date] = nil
      post_request(readings_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('date')
      expect(json['errors']['date']).to include("can't be blank")
    end
  end

  context 'Get All Readings' do
    let(:headers) { generate_headers }
    let(:user) { create :user }
    let(:url) { api_v1_readings_path }
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
      it 'should return all readings' do
        get url, headers: headers
        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body).to be_instance_of Array
        body.each do |reading|
          expect(reading).to include(params)
        end
      end
    end
  end

  context 'Update Reading' do
    let(:user) { create :user }
    let(:reading) { create :reading, user: user }
    let(:headers) { generate_headers(user) }
    let(:url) { api_v1_reading_path(reading.id) }
    let(:no_headers_url) { patch url }

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
      it 'should return all readings' do
        params = {
          fasting: 88.00
        }
        patch url, headers: headers, params: params
        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['fasting'].to_f).to be(params[:fasting])
      end
    end
  end

  context 'Delete Reading' do
    let(:user) { create :user }
    let(:reading) { create :reading, user: user }
    let(:headers) { generate_headers(user) }
    let(:url) { api_v1_reading_path(reading.id) }
    let(:no_headers_url) { delete url }

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
      it 'should delete a reading' do
        delete url, headers: headers
        expect(response.status).to eq(204)
      end
    end
  end
end
