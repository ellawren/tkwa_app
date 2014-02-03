class UsersController < ApplicationController

    before_filter :admin_user, only: [:index, :create, :new, :destroy]
  
    def index
        @title = "All users"
        @users = User.paginate(:page => params[:page])
    end
  
    def new
        @user = User.new
    end
  
    def create
        @user = User.new(params[:user])
        if @user.save
            redirect_to users_path
        else
            render 'new'
        end
    end
  
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            flash[:success] = "User updated successfully!"
            # technically all user updates should trigger a sign-in, but this means users cannot edit others' info
            # so only current users are signed in (they need to be or it will kick back to home on edit)
            if @user == current_user
                sign_in @user 
            end
            redirect_to(:back) 
        else
            render 'edit'
        end
    end
  
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
    end
  
    def index
        @users = User.paginate(page: params[:page])
    end

    def show
        @user = User.find(params[:id])
    end

    def forecast
        @user = User.find(params[:id])
    end

    def edit_forecast
        @user = User.find(params[:id])
        render :layout => 'modal' 
    end

    private

        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_path) unless current_user?(@user)
        end

        def correct_or_admin_user
            @user = User.find(params[:id])
            redirect_to(root_path) unless current_user?(@user) || current_user.admin?
        end
        
        def admin_user
            redirect_to(root_path) unless current_user.admin?
        end
  
end
