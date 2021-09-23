# require_relative "../../app/controllers/users_controller"
require "rails_helper"

RSpec.describe UsersController, type: :controller do

  let(:params){ JSON.parse(file_fixture('users.json').read) }
  let(:complete_params) { params['complete_params'] }

  describe '#POST create' do
    it 'does not register without name fields' do
      post :create, params: params['email_password']

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error'].keys).to match_array(%w[first_name last_name])
    end

    it 'registers successfully' do
      post :create, params: complete_params
      expect(response).to have_http_status(201)
      expect(response.parsed_body['email']).to eq "email@email.com"
    end

  it 'disallows registration for existing emails' do
      post :create, params: complete_params

      post :create, params: complete_params

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error']['email'][0]).to eq "has already been taken"
    end

    it 'restricts user object' do
      post :create, params: complete_params

      expect(response.parsed_body.keys).to match_array(%w[email first_name last_name])
    end

    it 'checks password strength' do
      weak_password_params = params['weak_password_params']
      post :create, params: weak_password_params

      expect(response.parsed_body['error']).to eq "Weak password"
    end
  end
end