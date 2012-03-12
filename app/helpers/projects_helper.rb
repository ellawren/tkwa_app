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

    def all_hours(id, phase)
      array = Array.new(TimeEntry.find_all_by_project_id_and_phase(id, phase))
    end
      
    def tracking_td(f, phase)
      actual_hours = @project.employee_actual(f.contact_id, phase.name)
      est_hours = eval("f.#{phase.shorthand}_hours")
      if est_hours == nil
        est = "<div class='input-spacer'></div>"
      else
        est = "<div class='uneditable-input span1 est'>#{strip(est_hours)}</div>"
      end

      if actual_hours == 0
        act = "<div class='act'></div></td>"
      else
        employee_id = Employee.find_by_contact_id(f.contact_id).id
        time_entries = TimeEntry.find_all_by_project_id_and_employee_id_and_phase(f.project_id, employee_id, phase.name)

        table_data = []
        time_entries.each do |t|
          table_data.push("<tr><td>#{t.task}</td><td class='text-right'>#{t.entry_total}</td></tr>")
        end
        act = "<a href='#' class='pop' rel='popover' title='#{employee_name(f.contact_id)} - #{phase.name}' data-content=\"
                <table class='table-condensed table-striped pop-table'><thead><tr><th>Task</th><th class='text-right'>Hours</th></tr></thead><tbody>#{table_data.join}</tbody>
                </table>\"><div class='uneditable-input span1 act #{is_over?(est_hours, actual_hours)}'>#{strip(actual_hours)}</div></a>"
      end

      "<td class=\"#{phase.name.gsub!(/[ ]*/, '')}\"> #{est} #{act} </td>".html_safe
    end

    def is_over?(estimated_hours, actual_hours)
      "over" if estimated_hours.to_f < actual_hours.to_f
    end

    def over_under(estimated_hours, actual_hours)
      unless actual_hours == 0
        result = (actual_hours - estimated_hours).to_f
        if result > 0
          "+" + strip(result)
        else
          strip(result)
        end
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

