class StaticPagesController < ApplicationController
include SessionsHelper
skip_before_filter :signed_in_user, :only => [:home]

  def home
    @message = Message.new
    render :layout => 'home_page' 
  end

  def potential_projects
	@potential_projects = Project.potential_projects
	@past_potential_projects = Project.past_potential_projects
  end
  
end
