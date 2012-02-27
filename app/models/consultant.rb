# == Schema Information
#
# Table name: consultants
#
#  id            :integer         not null, primary key
#  company       :string(255)
#  address       :string(255)
#  phone         :string(255)
#  contact       :string(255)
#  contact_email :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Consultant < ActiveRecord::Base
	validates :company, presence: true, length: { maximum: 50 }

	has_many :projects, :through => :consultant_teams
    has_many :consultant_teams, :dependent => :destroy
end
