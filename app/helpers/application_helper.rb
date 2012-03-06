module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "TKWA Database"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def is_active?(page_name)
    	"sel" if params[:action] == page_name
  end

  def is_current?(c_name)
      "class='active'" if params[:controller] == c_name
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

  def strip(num)
    number_with_precision(num, :strip_insignificant_zeros => true)
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, html_class)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", html_options={ :class => html_class })
  end


  
end
