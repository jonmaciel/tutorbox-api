class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result[:token], user: command.result[:user] }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
