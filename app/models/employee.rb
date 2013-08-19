# == Schema Information
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#  number     :integer
#  status     :string(255)
#  hire_date  :string(255)
#  leave_date :string(255)
#

class Employee < ActiveRecord::Base
	belongs_to :user
    belongs_to :contact

    has_many :timesheets
    has_many :data_records
    has_many :time_entries, :through => :timesheets
    has_many :plan_entries

    accepts_nested_attributes_for :data_records

    def name
    	Contact.find(self.contact_id).name
    end
end
