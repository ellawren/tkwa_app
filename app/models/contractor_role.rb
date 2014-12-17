# == Schema Information
#
# Table name: contractor_roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ContractorRole < ActiveRecord::Base

  	default_scope :order => "name ASC"
  	
end
