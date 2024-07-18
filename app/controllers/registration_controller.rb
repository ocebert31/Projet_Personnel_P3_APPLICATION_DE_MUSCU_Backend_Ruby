require 'jwt'

class RegistrationController < ApplicationController
  def create
    @user = User.new(user_params)
  
    if @user.save
      token = generate_jwt(@user) # On génére le JWT
      @user.update(jwt: token) # On met à jour l'utilisateur avec le JWT
      render json: { message: 'User created successfully', user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private

  def generate_jwt(user)
    payload = { user_id: user.id }
    secret = Rails.application.secrets.secret_key_base
    token = JWT.encode(payload, secret)
    token
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end



