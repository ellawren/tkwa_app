class UsersController < ApplicationController
  before_filter :correct_or_admin_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :new, :update, :destroy]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @user = User.new
    @contact = Contact.new
    @employee = @user.build_employee
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
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to edit_user_path(@user)
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
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def following
    if signed_in?
        @title = "Following"
    	@user = User.find(params[:id])
    	@users = @user.followed_users.paginate(page: params[:page])
    	render 'show_follow'
    else
      flash[:notice] = "Please sign in to view this page."
    	redirect_to(signin_path)
    end
  end

  def followers
    if signed_in?
    	@title = "Followers"
    	@user = User.find(params[:id])
    	@users = @user.followers.paginate(page: params[:page])
    	render 'show_follow'
    else
        flash[:notice] = "Please sign in to view this page."
    	redirect_to(signin_path)
    end
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def correct_or_admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
  
  
end
