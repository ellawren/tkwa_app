module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.week}"
  end
  
  def this_week
    Date.today.beginning_of_week
  end
  
  def week_array(date)
    start = date.beginning_of_week
    (start...start + 7.days).to_a
  end
end