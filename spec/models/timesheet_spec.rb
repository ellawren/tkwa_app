require 'spec_helper'

describe Timesheet do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: timesheets
#
#  id         :integer         not null, primary key
#  year       :integer         not null
#  week       :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  hours      :decimal(6, 2)
#  phase      :string(255)
#  task       :string(255)
#

