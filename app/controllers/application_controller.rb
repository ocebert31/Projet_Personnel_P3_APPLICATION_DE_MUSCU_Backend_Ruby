class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
  
    attr_reader :current_user
  
    def authenticate_user!
      token = request.headers['Authorization']&.split(' ')&.last
      decoded_token = JwtService.decode(token)
      @current_user = User.find_by(id: decoded_token['user_id']) if decoded_token
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    end
  end
  
