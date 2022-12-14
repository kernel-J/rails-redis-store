module Api
  module V1
    class UserController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      def create
        result = User::Create.call(params: user_params)

        if result.success?
          render json: result.success.to_hash, status: :created
        else
          render json: result.failure, status: :bad_request
        end
      end

      private 

      def user_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end