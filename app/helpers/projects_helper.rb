module ProjectsHelper

	include ActionView::Helpers::TextHelper

    def five_month_array
        date = Date.today.beginning_of_month
        array = []
        (1..5).each do |m|
            array.push([date.month, date.year])
            date = date - 1.month
        end
        array
    end

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
        array = Array.new(TimeEntry.where(project_id: id, phase_number: phase.number))
    end

    def floor_to(x)
        (self * 10**x).floor.to_f / 10**x
    end
      

    def fee_calc_td(f, phase)
      est_hours = eval("f.#{phase.shorthand}_hours")
      if est_hours == nil
        est = "<div class='input-spacer'></div>"
      else
        est = "<div class='input' >#{strip(est_hours)}</div>"
      end

      "<td class=\"phase-cell #{phase.name.gsub(/[ ]*/, '')}\">#{est}</td>".html_safe
    end


    def is_over?(estimated_hours, actual_hours)
      "over" if estimated_hours.to_f < actual_hours.to_f
    end

  # tracking table - remaining hours
  def remaining(g, a)
        goal = g.to_f
        actual = a.to_f
        if goal == 0 && actual == 0
         ""
        else 
          r = goal - actual
          if goal > actual
            "<div class=\"act sum\"><div class=\"num\">#{r}</div></div>".html_safe
          elsif goal <= actual
            "<div class=\"act sum over\"><div class=\"num\">#{r}</div></div>".html_safe
          end
        end
    end

  # tracking table - remaining currency
      def remaining_currency(g, a)
        goal = g.to_f
        actual = a.to_f
        if goal == 0 && actual == 0
          ""
        else 
          r = goal - actual
          number_to_currency(r, :precision => 0)
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
              TimeEntry.where(task: task).each do |t| 
                  array.push(t.entry_total)
              end
              array.map{|x| sum += x}
              str.push("<li> #{task} #{sum.to_f}</li>")
          end 
      str.join("").html_safe
    end

    def hours_by_task_array(entries)
      hash = {}
          task_array(entries).each do |task| 
              array = []
              sum = 0
              TimeEntry.find_all_by_task(task).each do |t| 
                  array.push(t.entry_total)
              end
              array.map{|x| sum += x}
              hash[task] = sum.to_f
          end 
      hash.sort_by { |k,v| -v }
    end


    def generate_percentages
        objects = year_to_date
        total = ytd("total")
        hash = {}
        #add non-billable value-key pairs to main array
        ytd_nb_categories_short.each do |category|
            hash[category] = ytd_nb_subtotal(category)
        end 
        #create billable value-key pairs and add to array
        ytd_projects.each do |project|
            hash[ Project.find(project).name ] = ytd_project_hours(project)
        end
        hash.sort_by { |k,v| -v }
      end


    def billable_rate(user_id)
      user = User.find(user_id)
      datarecord = DataRecord.find_by_user_id(user_id)
      number_to_currency(datarecord.billable_rate)
    end

    def estimated_billing(project, phase)

      # DataRecord.find_by_employee_id(Employee.find_by_contact_id(f.contact_id).id).billable_rate.to_f
    end

    def forecast_total_all(w, y)
        PlanEntry.current.where(:week => w, :year => y).sum(:hours)
    end

    def forecast_employee_week_total(user_id, four_month_array)
        x = []
        four_month_array.each do |w, y|
            plan_entries = PlanEntry.find_all_by_user_id_and_year_and_week(user_id, y, w)
            array = []
            sum = 0
            plan_entries.each do |e|
                if e.hours?
                    array.push(e.hours)
                end
            end
            array.map{|x| sum += x}
            if sum == 0
                x.push("")
            else
                x.push(sum)
            end
        end
        x
    end

end

