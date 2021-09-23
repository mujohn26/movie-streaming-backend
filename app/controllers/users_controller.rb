class UsersController < ApplicationController

  def create
    if weak_password?
      return render json: {error: 'Weak password'}, status: 400
    end
    user = User.new(user_params)
    if user.save
      render json: user.as_json(only: user_attributes), status: 201
    else
      render json: { error: user.errors }, status: 400
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


  def weak_password?
    email = params['email']
    password = params['password']
    strength = PasswordStrength.test(email, password)
    !strength.strong?
  end

end
