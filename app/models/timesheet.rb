# == Schema Information
#
# Table name: timesheets
#
#  id            :integer         not null, primary key
#  year          :integer         not null
#  week          :integer         not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  selected_year :integer
#  complete      :boolean         default(FALSE)
#  user_id       :integer         not null
#  notes         :text
#  printed       :boolean         default(FALSE)
#

class Timesheet < ActiveRecord::Base
  
    belongs_to :user

    has_many :time_entries, :dependent => :destroy
    accepts_nested_attributes_for :time_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank? }

    has_many :non_billable_entries, :dependent => :destroy
    accepts_nested_attributes_for :non_billable_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:category].blank? }

    # TOTALS
    def data_record
        d = DataRecord.find_by_user_id_and_year(self.user_id, self.year)
        if d && self.week >= d.start_week && self.week <= d.end_week 
            return d
        end
    end

    def vacation_record
        VacationRecord.find_or_create_by_year_and_user_id(year, user_id)
    end

    def total_hours
      	time_entries.sum(:day1) +  time_entries.sum(:day2) + time_entries.sum(:day3) + time_entries.sum(:day4) + time_entries.sum(:day5) + time_entries.sum(:day6) + time_entries.sum(:day7) 
    end

    def nb_total_hours
        non_billable_entries.sum(:day1) +  non_billable_entries.sum(:day2) + non_billable_entries.sum(:day3) + non_billable_entries.sum(:day4) + non_billable_entries.sum(:day5) + non_billable_entries.sum(:day6) + non_billable_entries.sum(:day7) 
    end

    def timesheet_total
        total_hours.to_f + nb_total_hours.to_f + holiday_total_hours.to_f
    end

    def vacation_hours
        if week == 1
            included_days = []
            non_billable_entries.where(category: "9").each do |entry|
                day_of_week = Date.new(year, 1, 1).strftime("%w").to_i + 1
                while day_of_week <= 7 do
                    included_days << eval("entry.day#{day_of_week}.to_f")
                    day_of_week = day_of_week + 1
                end
            end
            included_days.sum
        else  
            non_billable_entries.where(category: "9").sum(&:entry_total)
        end    
    end

    # SUMMARY
    def ytd_vacation
        Timesheet.where(year: year, user_id: user_id, week: 1..week).sum(&:vacation_hours)
    end

    def ytd_billable
        Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:total_hours)
    end

    def ytd_total
        Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:timesheet_total)
    end

    def goal
        data_record.hours_in_week * (week - data_record.start_week + 1)
    end

    def goal_with_overage
        (data_record.hours_in_week * (week - data_record.start_week + 1)) + -(data_record.overage_from_prev.to_f)
    end 
    
    # HOLIDAYS
    def holidays
        Holiday.find_all_by_year_and_week(self.year, self.week)
    end

    def holiday_hours
        data_record.holiday
    end

    def holiday_total_hours
        holidays.count * holiday_hours
    end

end
