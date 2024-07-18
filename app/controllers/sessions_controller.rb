require 'jwt'

class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
        token = generate_jwt(user) # Fonction pour générer un JWT avec l'utilisateur
        render json: { user: user, token: token }
      else
        render json: { error: 'Email ou mot de passe incorrect' }, status: :unauthorized
      end
    end
  
    private
  
    def generate_jwt(user)
      JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
    end
  end
  