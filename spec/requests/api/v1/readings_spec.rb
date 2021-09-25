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
end
