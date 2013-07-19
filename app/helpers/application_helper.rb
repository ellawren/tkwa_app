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

  def this_year
    Time.now.year
  end

  def this_week
    wk_1 = Time.now.beginning_of_year().beginning_of_week(start_day = :sunday) 
    wk_now = Time.now.beginning_of_week(start_day = :sunday)
    ((wk_now.to_date - wk_1.to_date).to_i / 7 ) + 1
  end

  def get_week_number(date)
    wk_1 = date.beginning_of_year().beginning_of_week(start_day = :sunday) 
    wk_now = date.beginning_of_week(start_day = :sunday)
    ((wk_now.to_date - wk_1.to_date).to_i / 7 ) + 1
  end

  def get_day(date)
    date.wday + 1
  end
  
  def is_active?(page_name)
    	"sel" if params[:action] == page_name
  end

  def is_set?(field, cat, label, select)
    unless field.blank?
        label + select
    else
        "<div class='input-row #{cat} show'></div>".html_safe
    end
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
     # execption for projects/:id/patterns
     if params[:controller] == "projects" && params[:action] == "patterns"
      "class='active'" if c_name.include?(params[:action])
     # all other pages
     else
      "class='active'" if c_name.include?(params[:controller])
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

  def remaining(g, a)
      goal = g.to_f
      actual = a.to_f
      if goal == 0 && actual == 0
        ""
      elsif goal >= actual
        "<div class=\"num\">#{goal - actual}</div><div class=\"tiny\">remaining</div>".html_safe
      elsif goal < actual
        "<div class=\"tiny\">over by</div><div class=\"num\">#{actual - goal}</div>".html_safe
      end
  end

    def remaining_currency(g, a)
      goal = g.to_f
      actual = a.to_f
      if goal == 0 && actual == 0
        ""
      elsif goal >= actual
        "<div class=\"num\">#{number_to_currency(goal - actual, :precision => 0)}</div><div class=\"tiny\">remaining</div>".html_safe
      elsif goal < actual
        "<div class=\"tiny\">over by</div><div class=\"num\">#{number_to_currency(actual - goal, :precision => 0)}</div>".html_safe
      end
  end

  def over_under_currency(g, a)
      goal = g.to_f
      actual = a.to_f
      if goal >= actual
        "(#{goal - actual})"
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

    def link_to_add_fields_2(name, f, association, html_class, partial=association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(partial.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
  end


  
end
