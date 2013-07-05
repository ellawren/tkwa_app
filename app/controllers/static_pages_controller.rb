class StaticPagesController < ApplicationController

  def messages
    if signed_in?
      @micropost  = Micropost.new
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def home
    @qp = Project.search(params[:q])
    @projects = @qp.result(:distinct => true)
    @qc = Contact.search(params[:q])
    @contacts = @qc.result(:distinct => true)
    render :layout => 'home_page' 
  end

  def help
  end
  
  def about
  end

  def admin
  end
  
end
