class StaticPagesController < ApplicationController
include SessionsHelper
skip_before_filter :signed_in_user, :only => [:home]

  def home
    @message = Message.new
    render :layout => 'home_page' 
  end

  def potential_projects
	@potential_projects = Project.potential_projects
	@inactive_projects = Project.inactive_projects
	@awarded_projects = Project.awarded_projects
  end
  
end
