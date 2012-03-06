# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  number              :decimal(8, 2)
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
#  billing_ext         :string(255)
#  contact_ext         :string(255)
#  start_date          :date
#  completion_date     :date
#  pd_start            :date
#  pd_end              :date
#  sd_start            :date
#  sd_end              :date
#  dd_start            :date
#  dd_end              :date
#  cd_start            :date
#  cd_end              :date
#  bid_start           :date
#  bid_end             :date
#  cca_start           :date
#  cca_end             :date
#  add_start           :date
#  add_end             :date
#  pd_percent          :integer
#  sd_percent          :integer
#  dd_percent          :integer
#  cd_percent          :integer
#  bid_percent         :integer
#  cca_percent         :integer
#  his_percent         :integer
#  int_percent         :integer
#  add_percent         :integer
#

class Project < ActiveRecord::Base
    has_many :contacts, :through => :employee_teams
    has_many :employee_teams, :dependent => :destroy

    has_many :consultants, :through => :consultant_teams
    has_many :consultant_teams, :dependent => :destroy

    has_and_belongs_to_many :services
    has_and_belongs_to_many :reimbursables
    has_and_belongs_to_many :consultant_roles

    # allows project page to add employees + consultants via team join model. must allow destroy.
    accepts_nested_attributes_for :consultant_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:consultant_id].blank? }
    accepts_nested_attributes_for :employee_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:contact_id].blank? }

    # allows project page to add items via checkboxes
    accepts_nested_attributes_for :services
    accepts_nested_attributes_for :reimbursables
    accepts_nested_attributes_for :consultant_roles

	validates :name, 	presence: true, length: { maximum: 50 }
	validates :number, 	presence: true, uniqueness: true

    def est_phase_total(var)
        employee_teams.sum(var+'_hours')
    end

    def est_total
        pd = est_phase_total('pd') || 0
        sd = est_phase_total('sd') || 0
        dd = est_phase_total('dd') || 0
        cd = est_phase_total('cd') || 0
        bid = est_phase_total('bid') || 0
        cca = est_phase_total('cca') || 0
        int = est_phase_total('int') || 0
        his = est_phase_total('his') || 0
        add = est_phase_total('add') || 0
        pd + sd + dd + cd + bid + cca + int + his + add
    end   




    
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

