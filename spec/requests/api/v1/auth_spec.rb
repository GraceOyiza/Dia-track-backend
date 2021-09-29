require 'rails_helper'

RSpec.describe 'SignUp', type: :request do
  let(:parameters) do
    { first_name: 'Jane',
      last_name: 'Doe',
      username: 'janedoe',
      email: 'jane@example.com',
      password: 'Password1',
      confirm_password: 'Password1',
      avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/images/bubbles.jpg')), 'image/jpeg') }
  end

  context 'User#Registration' do
    let(:url) { post api_v1_user_registration_path, params: parameters }
    scenario 'should return 422 if first_name is absent' do
      parameters[:first_name] = nil
      url
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['errors']).to have_key('first_name')
    end

    scenario 'should return 422 if last_name is absent' do
      parameters[:last_name] = nil
      url
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['errors']).to have_key('last_name')
    end

    scenario 'should return 422 if email is absent' do
      parameters[:email] = nil
      url
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['errors']).to have_key('email')
    end

    scenario 'should return 422 if password is absent' do
      parameters[:password] = nil
      url
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json['errors']).to have_key('password')
    end

    scenario 'should return 200 if all parameters are valid' do
      url
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['errors']).to be_nil
      expect(json['data']['first_name']).to eq(parameters[:first_name])
    end

    scenario 'should return 422 if user is already registered' do
      parameters.delete(:confirm_password)
      create :user, parameters
      url
      json = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(json['errors']).to have_key('email')
    end

    scenario 'should have token, client,uid in the headers' do
      parameters[:email] = 'test2@mail.com'

      url
      json = JSON.parse(response.body)

      expect(response.headers['access-token']).to be_truthy
      expect(response.headers['uid']).to be_truthy
      expect(response.headers['client']).to be_truthy
      expect(response.headers['token-type']).to eq('Bearer')
      expect(json['errors']).to be_nil
    end
  end

  context 'User Login' do
    let(:user) { create(:user) }
    let(:url) { api_v1_user_session }
    let(:login_credentials) { { email: user[:email], password: user[:password] } }

    context 'user credentials' do
      scenario 'should return 400 if email is absent' do
        login_credentials[:email] = ''
        login_user(login_credentials)
        expect(response).to have_http_status(401)
      end

      scenario 'should return 400 if email is invalid' do
        login_credentials[:email] = 'abc@wer.com'
        json = login_user(login_credentials)

        expect(response).to have_http_status(401)
        expect(json['errors']).to include('Invalid login credentials. Please try again.')
      end

      scenario 'should return 400 if password is absent' do
        login_credentials[:password] = ''
        login_user(login_credentials)
        expect(response).to have_http_status(401)
      end

      scenario 'should return 400 if password is invalid' do
        login_credentials[:password] = 'password'
        json = login_user(login_credentials)
        expect(response).to have_http_status(401)
        expect(json['errors']).to include('Invalid login credentials. Please try again.')
      end

      scenario 'should return no errors for valid credentials' do
        login_credentials[:password] = user.password
        json = login_user(login_credentials)

        expect(response).not_to have_http_status(401)
        expect(json['errors']).to be nil
      end

      scenario 'should return logged in user info' do
        login_credentials[:password] = user.password
        json = login_user(login_credentials)

        expect(response).not_to have_http_status(401)
        expect(json['data']['id']).to eq(user.id)
        expect(json['data']['first_name']).to eq(user.first_name)
        expect(json['data']['last_name']).to eq(user.last_name)
        expect(json['data']['email']).to eq(user.email)
        expect(json['data']['username']).to eq(user.username)
      end
    end
    context 'Token' do
      scenario 'should generate a token for successful login' do
        login_credentials[:password] = user.password
        login_user(login_credentials)
        expect(response.headers['access-token']).not_to be_nil
        expect(response.headers['client']).not_to be_nil
        expect(response.headers['uid']).not_to be_nil
        expect(response.headers['token-type']).not_to be_nil
      end
    end
  end
end
