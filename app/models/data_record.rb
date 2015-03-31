# == Schema Information
#
# Table name: data_records
#
#  id                :integer         not null, primary key
#  year              :integer
#  holiday           :decimal(4, 2)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  user_id           :integer         not null
#  pay_type          :string(255)     default("Salary")
#  start_week        :integer
#  end_week          :integer
#  hours_in_week     :decimal(4, 2)
#  overage_from_prev :decimal(6, 2)
#  billable_rate     :decimal(5, 2)
#  billable_per_week :decimal(4, 2)
#  stp_target        :decimal(6, 2)
#  mtg_target        :decimal(6, 2)
#  adm_target        :decimal(6, 2)
#  cmp_target        :decimal(6, 2)
#  edu_target        :decimal(6, 2)
#  sus_target        :decimal(6, 2)
#  mkp_target        :decimal(6, 2)
#  mkg_target        :decimal(6, 2)
#  com_target        :decimal(6, 2)
#

class DataRecord < ActiveRecord::Base

	default_scope order('year, start_week')
	belongs_to :user

	validates :user_id, :presence => true
	validates :year, :presence => true

	scope :active_users, {
        :select => "data_records.*",
        :joins => "INNER JOIN users ON users.id = data_records.user_id", 
        :conditions => ["active = ?", true ]
    }

	 def self.week_array
    	(self.start_week..self.end_week).to_a 
  	end

  	def week_array
    	(self.start_week..self.end_week).to_a 
  	end

    def user
      User.find(self.user_id)
    end

    def user_name
      self.user.name
    end

  	def duration 
  		self.start_week - self.end_week + 1
  	end

    def first_week_correction
      # calculates # of hours in first week, since it usually won't be 40
      # holiday hours in day is used as multiplier
      d = Date.new(year, 1, 1).wday + 1
      if d == 1
        d = 2
      end
      (7 - d) * holiday
    end

    def last_week_correction
      # calculates # of hours in last week, since it usually won't be 40
      # holiday hours in day is used as multiplier
      d = Date.new(year, 12, 31).wday + 1
      if d == 7
        d = 6
      end
      (d - 1) * holiday
    end

	before_save :set_defaults # used to be after_initialize

	def set_defaults
	    self.year ||= Date.today.cwyear
	    self.start_week ||= 1
        self.end_week ||= Date.new(Date.today.cwyear, 12, 28).cweek #calc for number of weeks in current year
	    self.hours_in_week ||= 40
	    self.holiday ||= 8
	    self.billable_rate ||= 90
      self.billable_per_week ||= self.hours_in_week
  	end

end
