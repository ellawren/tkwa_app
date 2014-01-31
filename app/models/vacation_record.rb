class VacationRecord < ActiveRecord::Base
	
  	attr_accessible :hours, :rollover, :user_id, :year
  	belongs_to :user

	validates :user_id, :presence => true
	validates :year, :presence => true

	scope :active_users, {
        :select => "vacation_records.*",
        :joins => "INNER JOIN users ON users.id = vacation_records.user_id", 
        :conditions => ["active = ?", true ]
    }

    def user_name
      User.find(self.user_id).name
    end

end
# == Schema Information
#
# Table name: vacation_records
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  year       :integer
#  hours      :decimal(6, 2)
#  rollover   :decimal(6, 2)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

