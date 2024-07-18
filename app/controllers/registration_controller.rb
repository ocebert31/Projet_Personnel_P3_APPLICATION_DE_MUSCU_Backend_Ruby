class RegistrationController < ApplicationController
  def create
    @user = User.new(user_params)
  
    if @user.save
      payload = { user_id: @user.id, exp: 24.hours.from_now.to_i }
      token = Authentication::JwtService.encode(payload)
      render json: { message: 'User created successfully', user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end



