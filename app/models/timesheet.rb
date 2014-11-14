# == Schema Information
#
# Table name: timesheets
#
#  id                    :integer         not null, primary key
#  year                  :integer         not null
#  week                  :integer         not null
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  selected_year         :integer
#  complete              :boolean         default(FALSE)
#  user_id               :integer         not null
#  notes                 :text
#  printed               :boolean         default(FALSE)
#  total_hours_saved     :decimal(5, 2)
#  nb_total_hours_saved  :decimal(5, 2)
#  timesheet_total_saved :decimal(5, 2)
#  vacation_hours_saved  :decimal(5, 2)
#

class Timesheet < ActiveRecord::Base
  
    belongs_to :user

    has_many :time_entries, :dependent => :destroy
    accepts_nested_attributes_for :time_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank? }

    has_many :non_billable_entries, :dependent => :destroy
    accepts_nested_attributes_for :non_billable_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:category].blank? }

    before_save do
        if self.complete == true
            self.total_hours_saved = self.total_hours
            self.nb_total_hours_saved = self.nb_total_hours
            self.timesheet_total_saved = self.timesheet_total
            self.vacation_hours_saved = self.vacation_hours
        else
            self.total_hours_saved = nil
            self.nb_total_hours_saved = nil
            self.timesheet_total_saved = nil
            self.vacation_hours_saved = nil
        end
    end


    # TOTALS
    def data_record
        d = DataRecord.where(user_id: self.user_id, year: self.year).first
        if d && self.week >= d.start_week && self.week <= d.end_week 
            return d
        end
    end

    def vacation_record
        VacationRecord.where(year: year, user_id: user_id).first_or_create
    end

    def total_hours
      	time_entries.sum(:total)
    end

    def nb_total_hours
        non_billable_entries.sum(:total)
    end

    def timesheet_total
        total_hours.to_f + nb_total_hours.to_f + holiday_total_hours.to_f
    end

    def vacation_hours 
        non_billable_entries.where(category: "9").sum(:total)
    end

    def nb_stp
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "1").sum(:total)
    end

    def nb_mtg
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "2").sum(:total)
    end

    def nb_adm
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "3").sum(:total)
    end

    def nb_cmp
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "4").sum(:total)
    end

    def nb_edu
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "5").sum(:total)
    end

    def nb_sus
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "6").sum(:total)
    end

    def nb_mkp
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "7").sum(:total)
    end

    def nb_mkg
        non_billable_entries.where(timesheet_id: self.id, user_id: user_id, category: "8").sum(:total)
    end

    # SUMMARY
    def ytd_vacation
        Timesheet.where(year: year, user_id: user_id, week: 1..week).sum(:vacation_hours_saved)
    end

    def ytd_billable
        Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(:total_hours_saved)
    end

    def ytd_total
        Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(:timesheet_total_saved)
    end

    def stp
        self.data_record.stp_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_stp).to_f
    end

    def mtg
        self.data_record.mtg_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_mtg).to_f
    end

    def adm
        self.data_record.adm_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_adm).to_f
    end

    def cmp
        self.data_record.cmp_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_cmp).to_f
    end

    def edu
        self.data_record.edu_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_edu).to_f
    end

    def mkp
        self.data_record.mkp_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_mkp).to_f
    end

    def mkg
        self.data_record.mkg_target.to_f - Timesheet.where(user_id: user.id, year: year, week: data_record.start_week..week).sum(&:nb_mkg).to_f
    end

    def nb_categories
        array = []
        
        array.push(NonBillableCategory.find(1) ) if self.data_record.stp_target.to_f > 0
        array.push(NonBillableCategory.find(2) ) if self.data_record.mtg_target.to_f > 0
        array.push(NonBillableCategory.find(3) ) if self.data_record.adm_target.to_f > 0
        array.push(NonBillableCategory.find(4) ) if self.data_record.cmp_target.to_f > 0
        array.push(NonBillableCategory.find(5) ) if self.data_record.edu_target.to_f > 0
        array.push(NonBillableCategory.find(7) ) if self.data_record.mkp_target.to_f > 0
        array.push(NonBillableCategory.find(8) ) if self.data_record.mkg_target.to_f > 0
            
        array
    end


    def goal
        if week == 53
            if data_record.start_week == 1
                data_record.hours_in_week * (52 - data_record.start_week) + data_record.first_week_correction + data_record.last_week_correction
            else
                data_record.hours_in_week * (52 - data_record.start_week + 1) + data_record.last_week_correction
            end
        else
            if data_record.start_week == 1
                data_record.hours_in_week * (week - data_record.start_week) + data_record.first_week_correction
            else
                data_record.hours_in_week * (week - data_record.start_week + 1) 
            end
        end
    end

    def goal_with_overage
      self.goal + -(data_record.overage_from_prev.to_f)
    end 
    
    # HOLIDAYS
    def holidays
        Holiday.where(year: self.year, week: self.week)
    end

    def holiday_hours
        data_record.holiday
    end

    def holiday_total_hours
        holidays.count * holiday_hours
    end

end
