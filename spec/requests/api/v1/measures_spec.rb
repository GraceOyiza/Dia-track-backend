require 'rails_helper'

RSpec.describe "Api::V1::Measures", type: :request do
  context 'Create' do
    params = nil
    let(:user) { create :user }
    let(:measures_url) { api_v1_measures_path }
    let(:headers) { generate_headers(user) }
    before(:each) do
      params = {
        title: 90.00,
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
end
