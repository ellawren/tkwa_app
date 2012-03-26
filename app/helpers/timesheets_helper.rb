module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.week}"
  end

  def get_date(day, param)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.new( param.year, 1, 1).beginning_of_week(start_day = :sunday) 

    # day_1 finds the first day of the given week number
    day_1 = (wk_1 + ((param.week-1) * 7)).to_date
    day_1 + (day-1)
  end

  def date_label(day, param)
    get_date(day, param).strftime("<span class='caps'>%a</span><br/>%-m/%-d").html_safe
  end

  def is_today?(day, param)
    true if get_date(day, param) == Date.today
  end

  def week_array(year)
    wk = weeks_in_year(year)
    (1..wk).to_a 
  end


  def is_week?(week)
      if params[:week] == week
        "sel" 
      elsif get_week_number(Date.today).to_i > week.to_i
        "past" 
      end
  end

  def sum_nonzero(day)
    if @timesheet.time_entries.sum(day) > 0
      @timesheet.time_entries.sum(day)
    end
  end

  def nonzero?(value)
    if value > 0
      value
    end
  end

  def weeks_in_year(year)
    last_day = Date.new(year, 12, 31)
    # if the last day of the year is a Saturday, then use that as the last week
    if ( (last_day.strftime("%w").to_i + 1) == 6 )
      get_week_number(last_day)
    # for all other case, week 1 is whatever week Jan1 fall in, so subtract 1 to get the last week
    else
      get_week_number(last_day) - 1
    end
  end

  def all_entries(project, timesheet)
    TimeEntry.find_all_by_project_id_and_timesheet_id(project, timesheet)
  end

  def first_entry(project, timesheet)
    TimeEntry.find_by_project_id_and_timesheet_id(project, timesheet)
  end

  def is_first?(object)
    true if ( all_entries(object.project_id, object.timesheet_id).count > 1 && object.id == first_entry(object.project_id, object.timesheet_id).id ) || all_entries(object.project_id, object.timesheet_id).count == 1
  end

  def unsaved?(object)
    true if object.project_id == nil
  end

  def nb_unsaved?(object)
    true if object.category == nil
  end

end