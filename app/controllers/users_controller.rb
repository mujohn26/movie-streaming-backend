class UsersController < ApplicationController

  def create
    if has_no_params?
      render json: {error:"all fields required"}, status: 400
    else
      user = User.new(user_params)
      if user.save
        render json: user.as_json(only: user_attributes), status: 201
      else
        render json: {error:"user already exists"}, status: 400
      end
    end
  end

  private
  def user_params
    password_hash = Hashes::PasswordHash.hash(params['password'])
    params.permit(user_attributes).slice(*user_attributes).merge({password: password_hash})
  end

  def user_attributes
    %w[first_name last_name email]
  end

  def has_no_params?
    first_name = params['first_name']
    last_name = params['last_name']
    email = params['email']
    password = params['password']
    email_password_absent = (email.nil? || email.length < 1) || (password.nil? || password.length < 1)
    first_name_last_name_absent = (first_name.nil? || first_name.length < 1)||  (last_name.nil? || last_name.length < 1)
    email_password_absent || first_name_last_name_absent  
  end

end
