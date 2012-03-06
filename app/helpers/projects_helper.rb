module ProjectsHelper
	include ActionView::Helpers::TextHelper

  	def list_roles(consultant, project)
  		roles_count = ConsultantTeam.count(:all, 
  			:conditions => [ "consultant_id = #{consultant} AND project_id = #{project}" ] )
  		roles_all = ConsultantTeam.find(:all, :select => "consultant_role", :conditions => [ "consultant_id = #{consultant} AND project_id = #{project}" ] ).map{ |r| r.consultant_role }
  		if roles_count >= 3
			   roles_all.join(', ')
		  else roles_count == 2
			   roles_all.join(' + ')
		  end	
  	end

    def employee_name(contactid)
      employee = Contact.find(contactid)
      employee.name
    end

  	def time_diff_in_natural_language(from_time, to_time)
  	  unless from_time.blank? || to_time.blank?
  		from_time = from_time.to_time if from_time.respond_to?(:to_time)
  		to_time = to_time.to_time if to_time.respond_to?(:to_time)
  		distance_in_seconds = ((to_time - from_time).abs).round
  		components = []

  		%w(year month week).each do |interval|
    	# For each interval type, if the amount of time remaining is greater than
    	# one unit, calculate how many units fit into the remaining time.
    		if distance_in_seconds >= 1.send(interval)
      			delta = (distance_in_seconds / 1.send(interval)).floor
      			distance_in_seconds -= delta.send(interval)
      			components << pluralize(delta, interval)
    		end
  		end

  		components.join(", ")
  	  end
	   end




end
