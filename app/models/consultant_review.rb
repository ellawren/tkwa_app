# == Schema Information
#
# Table name: consultant_reviews
#
#  id                 :integer         not null, primary key
#  consultant_id      :integer
#  consultant_role_id :integer
#  recommendation     :integer         default(3)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  notes              :string(255)
#

class ConsultantReview < ActiveRecord::Base

  	belongs_to :consultant
  	has_one :consultant_role

end
