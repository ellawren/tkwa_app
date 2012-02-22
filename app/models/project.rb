# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  number              :decimal(, )
#  location            :string(255)
#  client              :string(255)
#  building_type       :string(255)
#  client_type         :string(255)
#  status              :string(255)
#  contact_name        :string(255)
#  contact_phone       :string(255)
#  contact_email       :string(255)
#  billing_name        :string(255)
#  billing_address     :string(255)
#  billing_phone       :string(255)
#  billing_email       :string(255)
#  billing_type        :string(255)
#  billing_travel      :string(255)
#  billing_consultant  :string(255)
#  billing_outofpocket :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Project < ActiveRecord::Base

	validates :name, 	presence: true, length: { maximum: 50 }
	valid_number_regex = /\d{4,6}([\.]\d{2})?/i
	validates :number, 	presence: true, format: { with: valid_number_regex },
                    	uniqueness: true, length: { maximum: 9 }
		
end
