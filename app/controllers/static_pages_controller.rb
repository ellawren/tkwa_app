class StaticPagesController < ApplicationController

    include SessionsHelper
    skip_before_filter :signed_in_user, :only => [:home]

    def home
        if signed_in?
        	@message = Message.new
        	@messages = Message.studio_messages
        end
        render :layout => 'home_page' 
    end

    def living_buildings

    end

    def potential_projects
    	@potential_projects = Project.potential_projects
    	@past_potential_projects = Project.past_potential_projects
    end
  
end
