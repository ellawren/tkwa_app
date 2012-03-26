# == Schema Information
#
# Table name: non_billable_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  employee_id  :integer
#  category     :string(255)
#  description  :string(255)
#  day1         :decimal(4, 2)
#  day2         :decimal(4, 2)
#  day3         :decimal(4, 2)
#  day4         :decimal(4, 2)
#  day5         :decimal(4, 2)
#  day6         :decimal(4, 2)
#  day7         :decimal(4, 2)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class NonBillableEntry < ActiveRecord::Base
  default_scope order('category ASC')
  belongs_to :timesheet
  
  def entry_total
        d1 = day1.to_f
        d2 = day2.to_f
        d3 = day3.to_f
        d4 = day4.to_f
        d5 = day5.to_f
        d6 = day6.to_f
        d7 = day7.to_f
        d1 + d2 + d3 + d4 + d5 + d6 + d7
    end   
end


