require 'spec_helper'

describe Timesheet do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: timesheets
#
#  id                    :integer         not null, primary key
#  year                  :integer         not null
#  week                  :integer         not null
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  selected_year         :integer
#  complete              :boolean         default(FALSE)
#  user_id               :integer         not null
#  notes                 :text
#  printed               :boolean         default(FALSE)
#  total_hours_saved     :decimal(5, 2)
#  nb_total_hours_saved  :decimal(5, 2)
#  timesheet_total_saved :decimal(5, 2)
#  vacation_hours_saved  :decimal(5, 2)
#

