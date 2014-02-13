# == Schema Information
#
# Table name: employees
#
#  id              :integer         not null, primary key
#  contact_id      :integer
#  user_id         :integer
#  employee_number :integer
#  hire_date       :string(255)
#  leave_date      :string(255)
#  birth_month     :integer
#  birth_day       :integer
#  family          :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Employee do
  pending "add some examples to (or delete) #{__FILE__}"
end
