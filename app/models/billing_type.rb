class BillingType < ActiveRecord::Base
  attr_accessible :name
end
# == Schema Information
#
# Table name: billing_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

