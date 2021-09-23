# require_relative "../../app/controllers/users_controller"
require "rails_helper"

RSpec.describe UsersController, type: :controller do

  let(:params){ JSON.parse(file_fixture('users.json').read) }

  describe '#POST create' do
    it 'does not register user with empty fields' do
      post :create, params: {}

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error']).to eq "all fields required"
    end

    it 'does not register without name fields' do
      post :create, params: params['email_password']

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error']).to eq "all fields required"
    end

    it 'registers successfully' do
      post :create, params: params['complete_params']
      expect(response).to have_http_status(201)
      expect(response.parsed_body['email']).to eq "email@email.com"
    end

  it 'disallows registration for existing emails' do
      post :create, params: params['complete_params']

      post :create, params: params['complete_params']

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error']).to eq "user already exists"
    end

    it 'restricts user object' do
      post :create, params: params['complete_params']

      expect(response.parsed_body.keys).to match_array(%w[email first_name last_name])
    end
  end
end