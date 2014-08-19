# == Schema Information
#
# Table name: non_billable_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
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
#  user_id      :integer         not null
#  total        :decimal(5, 2)
#

class NonBillableEntry < ActiveRecord::Base

    default_scope order('category ASC')
    belongs_to :timesheet

    before_save :record_total

    private
    def record_total
      self.total = day1.to_f + day2.to_f + day3.to_f + day4.to_f + day5.to_f + day6.to_f + day7.to_f
    end  

end
