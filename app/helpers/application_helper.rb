module ApplicationHelper

    # Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "TKWA Database"
        if page_title.empty?
            base_title
        else
            "#{page_title} | #{base_title}"
        end
    end

    def javascript(*files)
        content_for(:head) { javascript_include_tag(*files) }
    end

    def this_year
        Date.today.cwyear
    end

    def prev_year
        this_year - 1
    end

    def curr_year
        Date.today.cwyear
    end

    def this_week
        Date.today.cweek
    end

    def prev_week
        if Date.today.cweek == 1
            Date.today.cweek
        else
            Date.today.cweek - 1
        end
    end

    def get_week_number(date)
        date.cweek
    end

    def get_day(date)
        # add 1 to weekday number because Sunday is 0 by default
        date.wday + 1
    end

    def phone(input)
        if input && input.length > 0
            if input.length == 7
                number_to_phone(input)
            elsif input.length > 7 && input.length <= 11
                number_to_phone(input, :area_code => true)
            elsif input.length > 11
                input.unpack('A3A3A4A4').join('-')
            else
                input
            end
        end
    end

    def nonzero(value)
        if value > 0
            number_with_precision(value, :precision => 2)
        end
    end

    def nonzero_currency(value)
        unless value.nil?
            if value > 0
                number_to_currency(value, :precision => 0)
            end
        end
    end

    def nonzero_percentage(value)
        if value > 0
            number_to_percentage(value * 100, :precision => 0)
        end
    end

    def month_shading(week, year)
        # jan / mar / may / jul / sep / nov
        string = ""

        if (Date.commercial(year, week, 3)).strftime("%b") == 'Jan' ||  # 3rd day = wed is in month
           (Date.commercial(year, week, 3)).strftime("%b") == 'Mar' ||
           (Date.commercial(year, week, 3)).strftime("%b") == 'May' ||
           (Date.commercial(year, week, 3)).strftime("%b") == 'Jul' ||
           (Date.commercial(year, week, 3)).strftime("%b") == 'Sep' ||
           (Date.commercial(year, week, 3)).strftime("%b") == 'Nov'

            string << "gray"
        end
        month = (Date.commercial(year, week, 3)).strftime("%m").to_i
        first_of_month = Date.new(year, month, 1)
        last_of_month = first_of_month.end_of_month
        week_start = Date.commercial(year, week, 1) - 4
        week_end = Date.commercial(year, week, 7)

        if week_start <= first_of_month && first_of_month <= week_end
            string << " first"
        end

        if week == (Date.today.beginning_of_week(start_day = :sunday) - 1.week).cweek
            string << " first"
        end

        if week_start + 2 <= last_of_month && last_of_month <= week_end + 2
            string << " last"
        end

        string
    end

    def four_month_array(start)
        start_date = start
        end_date = start_date + 17.weeks
        arr = []
        (start_date..end_date).each do |date|
            if date.strftime("%a") == "Sun"
                if get_week_number(date) == 1 
                    date = date.end_of_week(start_day = :sunday)
                    arr.push([get_week_number(date), date.year])
                else
                    arr.push([get_week_number(date), date.year])
                end
            end
        end
        arr
    end

    def four_month_header_array(start)
        start_date = start
        week_array = []

        (1..18).each do |i|
            week_array.push([start_date.cweek, start_date.year])
            start_date = start_date + 7
        end
    
        # add years to array
        year_arr = []
        week_array.each do |w, y|
            if year_arr.include?(y)
              year_arr.push("")
            else
              year_arr.push(y)
            end
        end

        # add months to array
        month_arr = []
        week_array.each do |w, y|
            month = (Date.commercial(y, w, 3)).strftime("%b") # 3rd day = wed is in month
            if month_arr.include?(month)
              month_arr.push("")
            else
              month_arr.push(month)
            end
        end

        # add weeks to array
        week_arr = []
        week_array.each do |w, y|
            week_arr.push([w, y])
        end

        # create string
        string = "<tr><th></th>"

        # add years to string
        year_arr.each do |a|
            if a != ""
                string << "<th class=\"first\">#{a}</th>"
            else
                string << "<th>#{a}</th>"
            end
        end
        string << "</tr><tr><th></th>"
        # add months to string
        month_arr.each do |a|
            if a != ""
                string << "<th class=\"first\">#{a}</th>"
            else
                string << "<th>#{a}</th>"
            end
        end
        string << "</tr><tr class=\"week\"><th></th>"
        # add weeks to string
        week_arr.each do |w, y|
            if w == this_week
                string << "<th class=\"current\"><a class=\"tip\" title=\"#{parse_date(w, y)}\">#{w}</a></th>"
            else  
                 string << "<th><a class=\"tip\" title=\"#{parse_date(w, y)}\">#{w}</a></th>"
            end
        end
        string << "</tr>"
        string.html_safe
    end

    def is_active?(page_name)
        # exception for contact data pages
        if params[:controller] == "contacts" && params[:action] == "data"
            "sel" if params[:cat] == page_name
        else
            "sel" if params[:action] == page_name
        end
    end

    def is_set?(field, cat, label, select)
        unless field.blank?
            label + select
        else
            "<div class='input-row #{cat} show'></div>".html_safe
        end
    end

    def current_employee
        Employee.find_by_user_id(current_user.id)
    end

    def link_to_add_category(name, f, cat, html_class)
        if f.object.cat01.blank?
            catz = "cat01"
        elsif f.object.cat02.blank?
            catz = "cat02"
        elsif f.object.cat03.blank?
            catz = "cat03"
        elsif f.object.cat04.blank?
            catz = "cat04"
        elsif f.object.cat05.blank?
            catz = "cat05"
        elsif f.object.cat06.blank?
            catz = "cat06"
        end

        label = f.label(" ", " ", class: "input-label" ) 
        select = f.collection_select("#{catz}", Category.all, :id, :name, { :include_blank => true }, { :class => "custom-select" } )
        text = label + select
        link_to_function(name, "add_category_fields(this, '#{catz}', '#{escape_javascript(text)}')", html_options={ :class => html_class })
    end

    def on_page?(controller, page_name)
        true if params[:controller] == controller && params[:action] == page_name
    end

    # pass in an array of items, filter our duplicates and return array of uniques.
    # used in holidays
    def unique_items(array)
        item_list = [] 
        array.uniq.each do |i| 
            item_list.push(i) 
        end 
        item_list
    end

    def is_current?(c_name)
        # exception for projects/:id/patterns
        if params[:controller] == "projects" && params[:action] == "patterns"
            "active" if c_name.include?(params[:action])
        # exception for /potential_projects
        elsif params[:controller] == "static_pages" && params[:action] == "potential_projects"
            "active" if c_name.include?(params[:action])
        # exception for /phases
        elsif params[:controller] == "phases" || 
            params[:controller] == "consultant_roles" || 
            params[:controller] == "employee_roles" || 
            params[:controller] == "reimbursables" ||
            params[:controller] == "services" ||
            params[:controller] == "tasks"
            "active" if c_name.include?('projects')
        # exception for /users/:id/forecast
        elsif params[:controller] == "users" && params[:action] == "forecast"
            "active" if c_name.include?('timesheets')
        # exception for vacations or expense reports
        elsif params[:controller] == "vacations" || params[:controller] == "expense_reports"
            "active" if c_name.include?('timesheets')
        # exception for /mailing_lists
        elsif params[:controller] == "mailing_lists"
            "active" if c_name.include?('contacts')

        # exceptions for /admin
        elsif ( params[:controller] == "static_pages" && params[:action] == "admin" ) ||
              ( params[:controller] == "users" && params[:action] == "index" ) ||
              ( params[:controller] == "users" && params[:action] == "new" ) ||
              ( params[:controller] == "holidays" ) ||
              ( params[:controller] == "categories" ) ||
              ( params[:controller] == "data_records" ) ||
              ( params[:controller] == "globals" )
            "active" if c_name.include?('admin')

        # all other pages
        else
            "active" if c_name.include?(params[:controller])
        end
    end

    def over_under(g, a)
        goal = g.to_f
        actual = a.to_f
        if goal >= actual
            "(#{goal - actual})"
        elsif goal < actual
            "+ #{actual - goal}"
        end
    end

    def over_under_currency(g, a)
        goal = g.to_f
        actual = a.to_f
        if goal >= actual
            "- #{number_to_currency(goal - actual)}"
        elsif goal < actual
            "+#{ number_to_currency(actual - goal)}"
        end
    end

    def formatted_date(date)
        if date
            date.strftime("%m/%d/%Y")
        else
            ""
        end
    end

    def short_date(date)
        if date
            date.strftime("%m/%d/%y")
        else
            ""
        end
    end

    def bday_format(date)
        if date
            date.strftime("%B %e")
        else
            ""
        end
    end

    def precise(num)
        number_with_precision(num, :precision => 2)
    end

    def strip(num)
        number_with_precision(num, :strip_insignificant_zeros => true)
    end

    def decimal(num)
        number_with_precision(num, :precision => 2)  
    end

    def errors_for(object, message=nil)
        html = ""
        unless object.errors.blank?
            html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
            if message.blank?
                if object.new_record?
                    html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
                else
                    html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
                end    
            else
                html << "<h5>#{message}</h5>"
            end  
            html << "\t\t<ul>\n"
            object.errors.full_messages.each do |error|
                html << "\t\t\t<li>#{error}</li>\n"
            end
            html << "\t\t</ul>\n"
            html << "\t</div>\n"
        end
        html
    end  

    def add_breaks(s)
        s.gsub(/\n/, '<br>').html_safe
    end

    def link_to_remove_fields(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: "delete fui-cross")
    end

    def link_to_remove_fields_2(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields_2(this)", class: "delete fui-cross")
    end

    def link_to_remove_fields_3(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields_3(this)", class: "delete fui-cross")
    end

    def link_to_remove_fields_4(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields_4(this)", class: "delete fui-cross")
    end

    def link_to_remove_fields_5(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_fields_5(this)", class: "delete fui-cross")
    end

    def link_to_remove_consultant_fields(name, f)
        f.hidden_field(:_destroy) + link_to_function(name, "remove_consultant_fields(this)", class: "delete fui-cross")
    end

    def link_to_add_category_fields(name, f, cat, html_class)
        label = f.label(" ", " ", class: "input-label" ) 
        select = f.collection_select("#{cat}", Category.all, :id, :name, { :include_blank => true }, { :class => "custom-select" } )
        text = label + select
        link_to_function(name, "add_category_fields(this, '#{cat}', '#{escape_javascript(text)}')", html_options={ :class => html_class })
    end

    def link_to_add_fields(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render(partial.to_s.singularize + "_fields", :f => builder)
        end
        link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

    def link_to_add_billing_fields(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render("consultant_billing_fields", :f => builder)
        end
        link_to_function(name, "add_billing_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

    def link_to_add_schedule_fields(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render(partial.to_s.singularize + "_fields", :f => builder)
        end
        link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

    def link_to_add_fields_2(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render(partial.to_s.singularize + "_fields", :f => builder)
        end
        link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

    def link_to_add_vacation_fields(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render(partial.to_s.singularize + "_fields", :f => builder)
        end
        link_to_function(name, "add_vacation_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

    def link_to_add_vacation_fields_2(name, f, association, html_class, partial=association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
          render("vacations/fields", :f => builder)
        end
        link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
    end

end
