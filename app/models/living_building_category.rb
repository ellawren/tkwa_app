# == Schema Information
#
# Table name: living_building_categories
#
#  id              :integer         not null, primary key
#  version         :string(255)
#  name            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  numerical_order :integer
#

class LivingBuildingCategory < ActiveRecord::Base
  
end

