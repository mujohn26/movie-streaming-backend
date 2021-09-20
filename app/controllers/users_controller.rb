class UsersController < ApplicationController

  def create
    email = params['email']
    password = params['password']
    if (email.nil? || email.length < 1) && (password.nil? || password.length < 1)
      render json: {error:"email and password required"}, status: 400
    else
      user = User.create(user_params)
      render json: user.as_json, status: 201
    end
  end

  private
  def user_params
    params.permit(%w[email password])
  end
end
