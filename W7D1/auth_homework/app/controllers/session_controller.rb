class SessionsController < ApplicationController
  def create
    user = User.find_by_credentrials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      render json: 'Credentials were wrong'
    else
      render json: "Welcome back #{user.username}!"
    end
  end


end