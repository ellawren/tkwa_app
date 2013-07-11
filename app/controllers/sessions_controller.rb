class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Signed in as #{user.name}!"
      redirect_back_or root_path
    else
      flash[:error] = 'Email and password do not match.'
      redirect_back_or root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
end
