module Api
  module V1
    class LoginController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      include ApiKeyAuthenticatable

      prepend_before_action :authenticate_with_api_key!

      def index
        result = Authentications::Login.call(params: login_params)
        puts "---------> result = #{result.inspect}"

        if result.success?
          render json: {:message => "success"}, status: :ok
        else
          render json: result.failure, status: :unauthorized
        end
      end

      private 

      def login_params
        params.require(:login).permit(:username, :password)
      end
    end
  end
end