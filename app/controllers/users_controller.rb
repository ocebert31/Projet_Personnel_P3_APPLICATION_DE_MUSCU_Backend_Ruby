# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show]
  
    def show
      render json: current_user
    end
  end
  