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
	validates :number, 	presence: true, uniqueness: true
    
    BUILDING_TYPES = [	"Condos", "Educational", "Financial", "HD Dealership", "Historic Restoration", 
    					"Hospitality", "Industrial", "Library", "Maintenance", "Manufacturing",
    					"Medical Elderly", "Medical Clinic", "Medical Hospital", "Mixed Use", 
    					"Municipal", "Museum", "Offices", "Performing Arts", "Planning", 
    					"Recreation", "Religious", "Residential Single", "Residential Multi",
    					"Retail", "Sustainable Design", "Teaching", "Urban Design"
    				 ]
    				 
    CLIENT_TYPES =   [	"Commercial", "Contractor", "Design Professional", "Developer", "Government",
    					"Industrial", "Institutional", "Owner"
    				 ]
    
    BILLING_TYPES =  			[ "Lump sum", "% of Construction Cost", "Hourly" ]
    BILLING_TRAVEL_TYPES =  	[ "Bill travel time (Phase 70)", "DO NOT BILL (included in fee)", ]
    BILLING_CONSULTANT_TYPES =  [ "Bill fees + 10% markup", "Bill fees with NO markup", "DO NOT BILL (included in fee)" ]
    				 
		
end

