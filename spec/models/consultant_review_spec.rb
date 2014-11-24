require 'spec_helper'

describe ConsultantReview do
  pending "add some examples to (or delete) #{__FILE__}"
end
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
#  name               :string(255)
#  role               :string(255)
#  defunct            :boolean
#  mbe                :boolean
#

