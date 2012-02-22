class StaticPagesController < ApplicationController

  def messages
    if signed_in?
      @micropost  = Micropost.new
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def home
  end

  def help
  end
  
  def about
  end
  
end
