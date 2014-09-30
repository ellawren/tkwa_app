# == Schema Information
#
# Table name: petals
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  numerical_order :integer
#  intent          :text
#  conditions      :text
#  subtitle        :string(255)
#  short_desc      :text
#

class Petal < ActiveRecord::Base
  
end

