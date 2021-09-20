# require_relative "../../app/controllers/users_controller"
require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe '#POST create' do
    it 'registers user with empty fields' do
      post :create, params: {}

      expect(response).to have_http_status(400)
      expect(response.parsed_body['error']).to eq "email and password required"
    end
  end
end