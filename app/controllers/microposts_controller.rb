class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to messages_path
    else
      @feed_items = []
      render 'static_pages/messages'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or messages_path
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to messages_path if @micropost.nil?
    end
    
end