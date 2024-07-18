class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
      token = Authentication::JwtService.encode(payload)
      render json: { token: token, user: user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
  