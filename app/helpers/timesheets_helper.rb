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

  def parse_date(week, year)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.new( year, 1, 1).beginning_of_week(start_day = :sunday) 

    # day_1 finds the first day of the given week number
    day_1 = (wk_1 + ((week-1) * 7)).to_date
    day_7 = day_1 + 6
    if day_1.month == day_7.month
      str = day_1.strftime("%b %-d") + "-" + day_7.strftime("%-d")
    else
      str = day_1.strftime("%b %-d") + "-" + day_7.strftime("%b %-d")
    end
    str
  end

  def year_begin(week, year)
    wk_1 = Date.new( year, 1, 1).beginning_of_week(start_day = :sunday) 
  end

  def parse_date_full(week, year)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.new( year, 1, 1).beginning_of_week(start_day = :sunday) 

    # day_1 finds the first day of the given week number
    day_1 = (wk_1 + ((week-1) * 7)).to_date
    day_7 = day_1 + 6
    if day_1.month == day_7.month
      str = day_1.strftime("%B %-d") + "-" + day_7.strftime("%-d, %Y")
    else
      str = day_1.strftime("%B %-d") + " - " + day_7.strftime("%B %-d, %Y")
    end
    str
  end

  def date_label(day, param)
    get_date(day, param).strftime("%a<div class='blanch'>%h<br>%e</div>").html_safe
  end

  def is_today?(day, param)
    "today" if get_date(day, param) == Date.today
  end

  def week_array(year)
    wk = weeks_in_year(year)
    (1..wk).to_a 
  end

  def is_week?(week)
      if (params[:week] == week) && (get_week_number(Date.today).to_i == week.to_i)
        "curr sel tip-bottom" 
      elsif params[:week] == week
        "sel tip-bottom" 
      elsif get_week_number(Date.today).to_i == week.to_i
        "curr tip-bottom" 
      elsif get_week_number(Date.today + 7).to_i > week.to_i
        "past tip-bottom" 
      else
        "tip-bottom"
      end
  end

  def sum_nonzero(day)
    if @timesheet.time_entries.sum(day) > 0
      @timesheet.time_entries.sum(day)
    end
  end

  def sum_nb_nonzero(day)
    if @timesheet.non_billable_entries.sum(day) > 0
      @timesheet.non_billable_entries.sum(day)
    end
  end

  def nonzero?(value)
    if value > 0
      value
    end
  end

  def timesheet_sum(day)
    if @timesheet.time_entries.sum(day) + @timesheet.non_billable_entries.sum(day) > 0
      @timesheet.time_entries.sum(day) + @timesheet.non_billable_entries.sum(day)
    end
  end

  def weeks_in_year(year)
    last_day = Date.new(year, 12, 31)
    # if the last day of the year is a Saturday, then use that as the last week
    if ( (last_day.strftime("%w").to_i + 1) == 6 )
      get_week_number(last_day)
    # for all other case, week 1 is whatever week Jan1 falls in, so subtract 1 to get the last week
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

  def color_array
    colors = ['#dbdca1','#ccd8ad', '#b5d7b1', '#9ccdb1', '#9cc5c1',  '#9cc6d1', '#9cc2d4', '#b6c3d9', '#bfbdda', '#bfbbd3', '#d5bad9']
  end

  def over?(var)
      reg = /^[+]/
        if var.match(reg)
          "class='red'"
        else
          "class='green'"
        end
  end

  def over_s?(var)
      reg = /^[+]/
        if var.match(reg)
          "red"
        else
          "green"
        end
  end

end  