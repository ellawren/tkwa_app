class PotentialProject < ActiveRecord::Base
	validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

    has_and_belongs_to_many :services
    has_and_belongs_to_many :reimbursables
    has_and_belongs_to_many :consultant_roles
    has_and_belongs_to_many :phases
    has_and_belongs_to_many :tasks

    # allows potential project page to add items via checkboxes
    accepts_nested_attributes_for :services
    accepts_nested_attributes_for :reimbursables
    accepts_nested_attributes_for :consultant_roles
    accepts_nested_attributes_for :phases
    accepts_nested_attributes_for :tasks
    
end
# == Schema Information
#
# Table name: potential_projects
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  location      :string(255)
#  client        :string(255)
#  contact_name  :string(255)
#  contact_phone :string(255)
#  contact_email :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

