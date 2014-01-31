require 'spec_helper'

describe VacationRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: vacation_records
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  year       :integer
#  hours      :decimal(6, 2)
#  rollover   :decimal(6, 2)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

