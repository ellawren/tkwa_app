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

	after_initialize :set_defaults

	def set_defaults
	    self.year ||= Date.today.cwyear
	    self.start_week ||= 1
        self.end_week ||= Date.new(Date.today.cwyear, 12, 28).cweek #calc for number of weeks in current year
	    self.hours_in_week ||= 40
	    self.holiday ||= 8
	    self.billable_rate ||= 90
  	end

end
