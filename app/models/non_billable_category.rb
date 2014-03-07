# == Schema Information
#
# Table name: non_billable_categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  shorthand  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class NonBillableCategory < ActiveRecord::Base
  

end

