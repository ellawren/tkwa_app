class BuildingType < ActiveRecord::Base
  default_scope :order => "name"
end
# == Schema Information
#
# Table name: building_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

