class SessionsController < ApplicationController

  skip_before_filter :signed_in_user

    def create
        user = User.where(email: params[:session][:email]).first
        if user && user.authenticate(params[:session][:password])
            sign_in user
            flash[:success] = "Signed in as #{user.name}!"
            redirect_to root_path
        else
            flash[:error] = 'Email and password do not match.'
            redirect_to root_path
        end
    end

    def destroy
        sign_out
        redirect_to root_path
    end
  
end
