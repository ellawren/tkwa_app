require 'spec_helper'

describe ScheduleItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: schedule_items
#
#  id         :integer         not null, primary key
#  project_id :integer
#  phase_id   :integer
#  desc       :string(255)
#  start      :string(255)
#  end        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  duration   :string(255)
#  start_date :date
#  meeting    :string(255)     default("task")
#

