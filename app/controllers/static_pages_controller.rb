class StaticPagesController < ApplicationController
include SessionsHelper
skip_before_filter :signed_in_user, :only => [:home]

  def home
    @message = Message.new
    render :layout => 'home_page' 
  end
  
end
