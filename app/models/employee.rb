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
    default_scope joins(:contact).order('contacts.name ASC')

    has_many :timesheets
    has_many :data_records
    has_many :time_entries, :through => :timesheets
    has_many :plan_entries

    accepts_nested_attributes_for :data_records
    accepts_nested_attributes_for :plan_entries, :allow_destroy => true
    accepts_nested_attributes_for :employee_teams


    def name
    	Contact.find(self.contact_id).name
    end

    scope :current, {
        :select => "employees.*",
        :conditions => ["leave_date = ?", '' ]
    }

    def employee_forecast(project_id, four_month_array)
        entries = []
        four_month_array.each do |w, y|
            entries.push(PlanEntry.find_or_create_by_project_id_and_employee_id_and_year_and_week(project_id, self.id, y, w))
        end
        entries
    end

    def forecast_week_total(four_month_array)
        x = []
        four_month_array.each do |w, y|
            plan_entries = PlanEntry.find_all_by_employee_id_and_year_and_week(self.id, y, w)
            array = []
            sum = 0
            plan_entries.each do |e|
                if e.hours?
                    array.push(e.hours)
                end
            end
            array.map{|x| sum += x}
            if sum == 0
                x.push("")
            else
                x.push(sum)
            end
        end
        x
    end
end
