require 'spec_helper'

describe NonBillableHour do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: non_billable_hours
#
#  id         :integer         not null, primary key
#  hours      :integer
#  year       :integer
#  week       :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean         default(TRUE)
#

