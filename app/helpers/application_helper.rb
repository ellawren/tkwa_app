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
  
end
