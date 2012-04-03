# == Schema Information
#
# Table name: timesheets
#
#  id            :integer         not null, primary key
#  year          :integer         not null
#  week          :integer         not null
#  employee_id   :integer         not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  selected_year :integer
#  complete      :boolean         default(FALSE)
#


class Timesheet < ActiveRecord::Base
  default_scope :order => "year DESC, week DESC"
  
  belongs_to :employee
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank? }

  has_many :non_billable_entries, :dependent => :destroy
  accepts_nested_attributes_for :non_billable_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:category].blank? }

  YEARS =   [	"2012", "2011" ]

  NON_BILLABLE_CATEGORIES =   [ "Admin Meeting", "Computer Systems", "Education/Training", "Marketing", "Staff/Scheduling Meeting",  
                                "Studio Projects", "Sustainable Research", "Vacation" ]

  def total_hours
  	time_entries.sum(:day1) +  
  	time_entries.sum(:day2) + 
  	time_entries.sum(:day3) + 
  	time_entries.sum(:day4) + 
  	time_entries.sum(:day5) + 
  	time_entries.sum(:day6) + 
  	time_entries.sum(:day7) 
  end

  def nb_total_hours
    non_billable_entries.sum(:day1) +  
    non_billable_entries.sum(:day2) + 
    non_billable_entries.sum(:day3) + 
    non_billable_entries.sum(:day4) + 
    non_billable_entries.sum(:day5) + 
    non_billable_entries.sum(:day6) + 
    non_billable_entries.sum(:day7) 
  end

  def timesheet_total
    total_hours.to_f + nb_total_hours.to_f
  end

  def year_to_date
      year_to_date = Timesheet.find(:all, :conditions => ['employee_id = ? AND year = ? AND week <= ?', employee.id, year, week ])
  end

  def all_hours(line, column)
        employee = Employee.find(employee_id)
        data_record = DataRecord.find_by_employee_id_and_year(employee_id, year)
        weeks = weeks_in_year(year)
        week_total = data_record.week || 40
        week_billable = data_record.billable || 40
        week_non_billable = week_total - week_billable
        year_total = week_total * weeks
        year_billable = week_billable  * weeks
        year_non_billable = week_non_billable * weeks

        if column == "target"
              eval("year_#{line}")
        elsif column == "remaining"
              over_under_calc( eval("year_#{line}") , ytd(line) )
        elsif column == "over-under"
              over_under_calc( (eval("week_#{line}") * week) , ytd(line) )
        elsif column == "completed"
              ytd(line)
        end
  end

  def over_under_calc(g, a)
      goal = g.to_f
      actual = a.to_f
      if goal >= actual
        "(#{goal - actual})"
      elsif goal < actual
        "+ #{actual - goal}"
      end
  end

  def ytd(var)
    array = []
    year_to_date.each do |y|
        if var == "total"
          array.push(y.timesheet_total.to_f)
        elsif var == "billable"
          array.push(y.total_hours.to_f)
        elsif var == "non_billable"
          array.push(y.nb_total_hours.to_f)
        end
      end
    array.sum
  end

  def get_week_number(date)
    wk_1 = date.beginning_of_year().beginning_of_week(start_day = :sunday) 
    wk_now = date.beginning_of_week(start_day = :sunday)
    ((wk_now.to_date - wk_1.to_date).to_i / 7 ) + 1
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

  def ytd_nb_categories
    array = []
    year_to_date.each do |y|
      y.non_billable_entries.each do |entry|
          array.push(entry.category)
      end
    end
    array.push("Vacation")
    unique_items(array).sort
  end

  def ytd_nb_categories_short
    array = []
    year_to_date.each do |y|
      y.non_billable_entries.each do |entry|
          array.push(entry.category)
      end
    end
    unique_items(array).sort
  end

  def ytd_nb_subtotal(category)
    array = []
    year_to_date.each do |y|
      y.non_billable_entries.each do |entry|
        if entry.category == category
          array.push(entry.entry_total)
        end
      end
    end
    array.sum
  end

  def ytd_projects
    array = []
    year_to_date.each do |y|
      y.time_entries.each do |entry|
          array.push(entry.project_id)
      end
    end
    unique_items(array)
  end

  def ytd_project_hours(project)
    array = []
    year_to_date.each do |y|
      y.time_entries.each do |entry|
        if entry.project_id == project
          array.push(entry.entry_total)
        end
      end
    end
    array.sum
  end

  def unique_items(array)
      item_list = [] 
      array.uniq.each do |i| 
         item_list.push(i) 
      end 
      item_list
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

  def open?
    true if complete == false
  end

  
  
end

  

