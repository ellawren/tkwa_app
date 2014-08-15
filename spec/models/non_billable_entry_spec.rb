require 'spec_helper'

describe NonBillableEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
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

