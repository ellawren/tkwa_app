module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.week}"
  end

  def tkwa_date(y, w, d)
    # custom date parse so that last days are not carried over to next year
    # the minus one at the end corrects for a sunday week start instead of monday
      parsed = (Date.commercial(y, 1, 1) + ((w - 1 ) * 7) + (d - 1)) - 1
    # return date only if it is in the current year
    if parsed.year == y
      parsed
    else
      nil
    end
  end

  def tkwa_date_label(tkwa_date)
    tkwa_date.strftime("%a<div class='blanch'>%h<br>%e</div>").html_safe
  end

  def get_date(day, param)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.commercial(param.year, 1, 1).beginning_of_week(start_day = :sunday)  

    # day_1 finds the first day of the given week number
    day_1 = (Date.commercial(param.year, 1, 1) + ((param.week - 1 ) * 7) ) - 1
    day_1 + (day-1)
  end

  def parse_date(week, year)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.commercial(year, 1, 1).beginning_of_week(start_day = :sunday)  

    # day_1 finds the first day of the given week number
    day_1 = (Date.commercial(year, 1, 1) + ((week - 1 ) * 7) ) - 1
    day_7 = day_1 + 6
    if day_1.year < year
      str = Date.new(year, 1, 1).strftime("%b %-d") + "-" + day_7.strftime("%-d")
    elsif day_7.year > year
      str = day_1.strftime("%b %-d") + " - " + Date.new(year,12,31).strftime("%-d")
    elsif day_1.month == day_7.month
      str = day_1.strftime("%b %-d") + "-" + day_7.strftime("%-d")
    else
      str = day_1.strftime("%b %-d") + "-" + day_7.strftime("%b %-d")
    end
    str
  end

  def weeks_in_year(year)
    Date.new(year, 12, 28).cweek
  end

  def year_begin(week, year)
    wk_1 = Date.commercial(year, 1, 1).beginning_of_week(start_day = :sunday) 
  end

  def parse_date_full(week, year)
    # wk_1 finds the first day of the first week of the given year
    wk_1 = Date.commercial(year, 1, 1).beginning_of_week(start_day = :sunday)  

    # day_1 finds the first day of the given week number
    day_1 = (Date.commercial(year, 1, 1) + ((week - 1 ) * 7) ) - 1
    day_7 = day_1 + 6
    if day_1.year < year
      str = Date.new(year, 1, 1).strftime("%B %-d") + "-" + day_7.strftime("%-d, %Y")
    elsif day_7.year > year
      str = day_1.strftime("%B %-d") + " - " + Date.new(year,12,31).strftime("%B %-d, %Y")
    elsif day_1.month == day_7.month
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
    wk = weeks_in_year(year) + 1
    (1..wk).to_a 
  end

  def is_week_open?(week, year, user_id)
      if (params[:week] == week) && (get_week_number(Date.today).to_i == week.to_i) && year == this_year
        "curr sel tip-bottom" 
      elsif params[:week] == week
        "sel tip-bottom" 
      elsif get_week_number(Date.today).to_i == week.to_i && year == this_year
        "curr tip-bottom" 
      elsif get_week_number(Date.today + 7).to_i > week.to_i
        # if past, check if open
        if ts = Timesheet.where(:user_id => user_id, :year => year, :week => week).first_or_create
          t = ts.complete
          n = ts.data_record.present? ? "" : "no-data"
        end
        "past tip-bottom #{t} #{n}" 
      else
        "tip-bottom"
      end
  end

  def is_week?(week, year)
      if (params[:week] == week) && (get_week_number(Date.today).to_i == week.to_i) && year == this_year
        "curr sel tip-bottom" 
      elsif params[:week] == week
        "sel tip-bottom" 
      elsif get_week_number(Date.today).to_i == week.to_i && year == this_year
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
    arr = []
    day_num = day.to_s.gsub(/[^0-9]/, '').to_i
    if @timesheet.holidays.count > 0
        @timesheet.holidays.each do |h|
            if day_num == h.day
                arr.push(@timesheet.holiday_hours)
            end
        end
    end
    arr.push(@timesheet.time_entries.sum(day))
    arr.push(@timesheet.non_billable_entries.sum(day))
    arr.inject{|sum,x| sum + x }
  end

  def weeks_class(year)
    if weeks_in_year(year) == 53
      "fifty-three"
    elsif weeks_in_year(year) == 52
      "fifty-two"
    end
  end

  def all_entries(project, timesheet)
    TimeEntry.where(project_id: project, timesheet_id: timesheet)
  end

  def first_entry(project, timesheet)
    TimeEntry.where(project_id: project, timesheet_id: timesheet).first
  end

  def is_first?(object)
    true if ( all_entries(object.project_id, object.timesheet_id).count > 1 && object.id == first_entry(object.project_id, object.timesheet_id).id ) || all_entries(object.project_id, object.timesheet_id).count == 1
  end

  def unsaved?(object)
    if object.project_id == nil
        true 
    else
        false
    end
  end

  def nb_unsaved?(object)
    if object.category == nil
      true 
    else
      false
    end
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