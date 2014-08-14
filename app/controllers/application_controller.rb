class ApplicationController < ActionController::Base
    protect_from_forgery
    include SessionsHelper

    before_filter :signed_in_user

        private
        before_filter :instantiate_controller_and_action_names

        def authorize_admin
        	redirect_to "/error" if current_user.admin != true
        	#redirects to error page
	    end

        def instantiate_controller_and_action_names
            @current_action = action_name
            @current_controller = controller_name
        end


        # only enable mini profiler for admin users
        def authorize
          if current_user.is_admin?
            Rack::MiniProfiler.authorize_request
          end
        end
        
end
