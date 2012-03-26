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
      array = Array.new(TimeEntry.find_all_by_project_id_and_phase_number(id, phase.number))
    end
      
    def tracking_td(f, phase)
      actual_hours = @project.employee_actual(f.contact_id, phase.number)
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
        time_entries = TimeEntry.find_all_by_project_id_and_employee_id_and_phase_number(f.project_id, employee_id, phase.number)

        str = []
            task_array(time_entries).each do |task| 
                array = []
                sum = 0
                TimeEntry.find_all_by_project_id_and_employee_id_and_phase_number_and_task(f.project_id, employee_id, phase.number, task).each do |t| 
                    array.push(t.entry_total)
                end
                array.map{|x| sum += x}
                str.push("<tr><td>#{task}</td><td>#{sum.to_f}</td></tr>")
            end 

        act = "<a class='pop' rel='popover' title='#{employee_name(f.contact_id)} - #{phase.name}' data-content=\"
                <table class='table-condensed table-striped pop-table'><thead><tr><th>Task</th><th>Hours</th></tr></thead><tbody>#{str.join}</tbody>
                </table>\"><div class='uneditable-input span1 act #{is_over?(est_hours, actual_hours)}'>#{strip(actual_hours)}</div></a>"
      end

      "<td class=\"#{phase.name.gsub(/[ ]*/, '')}\"> #{est} #{act} </td>".html_safe
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

    def unique_tasks(array)
        task_list = [] 
        array.uniq.each do |task| 
           task_list.push(task) 
        end 
        task_list
    end

    def task_array(all_entries)
        task_array = [] 
        all_entries.each do |entry| 
            task_array.push(entry.task) 
        end 
        unique_tasks(task_array)
    end


    def hours_by_task(entries)
      str = []
          task_array(entries).each do |task| 
              array = []
              sum = 0
              TimeEntry.find_all_by_task(task).each do |t| 
                  array.push(t.entry_total)
              end
              array.map{|x| sum += x}
              str.push("<li> #{task} #{sum.to_f}</li>")
          end 
      str.join("").html_safe
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

