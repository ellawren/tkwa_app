# == Schema Information
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#  number     :integer
#  status     :string(255)
#  hire_date  :datetime
#  leave_date :datetime
#

require 'spec_helper'

describe Employee do
  pending "add some examples to (or delete) #{__FILE__}"
end