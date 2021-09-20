class UsersController < ApplicationController

  def create 
    render json: {error:"email and password required"}, status: 400
  end
end
