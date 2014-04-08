require 'spec_helper'

describe UnassignedHour do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: unassigned_hours
#
#  id         :integer         not null, primary key
#  hours      :integer
#  project_id :integer
#  year       :integer
#  week       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean         default(TRUE)
#

