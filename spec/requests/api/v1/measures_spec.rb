require 'rails_helper'

RSpec.describe 'Api::V1::Measures', type: :request do
  context 'Create' do
    params = nil
    let(:user) { create :user }
    let(:measures_url) { api_v1_measures_path }
    let(:headers) { generate_headers(user) }
    before(:each) do
      params = {
        title: 90.00
      }
    end

    it 'should validate presence of title' do
      params[:title] = nil
      post_request(measures_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('title')
      expect(json['errors']['title']).to include("can't be blank")
    end

    it 'should create a measure' do
      params[:tile] = 'Height'
      post_request(measures_url, params, headers)
      JSON.parse(response.body)

      expect(response.status).to eql(201)
    end
  end

  context 'Show' do
    let(:user) { create :user }
    let(:another_user) { create :user }
    let(:measure) { create :measure, user: user }
    let(:measures_url) { get api_v1_measure_path(measure.id) }
    let(:headers) { generate_headers(user) }
    let(:wrong_headers) { generate_headers(another_user) }

    it 'should validate presence of headers' do
      measures_url

      expect(response.status).to eql(401)
    end

    it 'should display a measure' do
      get api_v1_measure_path(measure.id), headers: headers
      JSON.parse(response.body)

      expect(response.status).to eql(200)
    end
  end

  context 'Create Measurement' do
    params = nil
    let(:user) { create :user }
    let(:another_user) { create :user }
    let(:measure) { create :measure, user: user }
    let(:measures_url) { "/api/v1/measures/#{measure.id}/new" }
    let(:headers) { generate_headers(user) }
    let(:wrong_headers) { generate_headers(another_user) }

    before(:each) do
      params = {
        value: 90.0,
        date: Faker::Date.forward(days: 23)
      }
    end

    it 'should validate presence of value' do
      params[:value] = nil
      post_request(measures_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('value')
      expect(json['errors']['value']).to include("can't be blank")
    end

    it 'should validate presence of date' do
      params[:date] = nil
      post_request(measures_url, params, headers)
      json = JSON.parse(response.body)

      expect(response.status).to eql(422)
      expect(json['errors']).to have_key('date')
      expect(json['errors']['date']).to include("can't be blank")
    end

    it 'should create a measurement' do
      params[:value] = 90.33
      params[:date] = Faker::Date.forward(days: 23)
      post_request(measures_url, params, headers)
      JSON.parse(response.body)

      expect(response.status).to eql(201)
    end

    it 'should return 403 if user does not own measure' do
      params[:value] = 90.33
      params[:date] = Faker::Date.forward(days: 23)
      post_request(measures_url, params, wrong_headers)
      JSON.parse(response.body)

      expect(response.status).to eql(403)
    end
  end
end
