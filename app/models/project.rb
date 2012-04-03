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
#  client_url          :string(255)
#

class Project < ActiveRecord::Base
    default_scope order('name')

    has_many :contacts, :through => :employee_teams
    has_many :employee_teams, :dependent => :destroy

    has_many :consultants, :through => :consultant_teams
    has_many :consultant_teams, :dependent => :destroy

    has_and_belongs_to_many :services
    has_and_belongs_to_many :reimbursables
    has_and_belongs_to_many :consultant_roles
    has_and_belongs_to_many :phases
    has_and_belongs_to_many :tasks

    # allows project page to add employees + consultants via team join model. must allow destroy.
    accepts_nested_attributes_for :consultant_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:consultant_id].blank? }
    accepts_nested_attributes_for :employee_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:contact_id].blank? }

    # allows project page to add items via checkboxes
    accepts_nested_attributes_for :services
    accepts_nested_attributes_for :reimbursables
    accepts_nested_attributes_for :consultant_roles
    accepts_nested_attributes_for :phases
    accepts_nested_attributes_for :tasks

	validates :name, 	presence: true, length: { maximum: 50 }
	validates :number, 	presence: true, uniqueness: true


    def available_phases
        available_phases = []
        self.phase_ids.each do |t|
          available_phases.push(Phase.find_by_id(t))
        end
        available_phases
    end


    def employee_hours(total_hours, contactid, phase)
      employeeid = Employee.find_by_contact_id(contactid).id
      total_hours.find_all_by_employee_id_and_phase_number(employeeid, phase)
    end

    # sum of estimated hours entered for project, by phase
    def phase_est(var)
        employee_teams.sum(var+'_hours')
    end

    # sum of actual hours entered for project, by phase
    def phase_actual(phase)
        time_entries = TimeEntry.find_all_by_project_id_and_phase_number(self.id, phase)
        array = []
        sum = 0
        time_entries.each do |t| 
            array.push(t.entry_total)
        end
        array.map{|x| sum += x}
        sum
    end

    # sum of actual hours entered for project, by employee
    def employee_actual(contact_id, phase)
        if phase == "Total"
            employee_id = Employee.find_by_contact_id(contact_id).id
            time_entries = TimeEntry.find_all_by_project_id_and_employee_id(self.id, employee_id)
            array = []
            sum = 0
            time_entries.each do |t| 
                array.push(t.entry_total)
            end
            array.map{|x| sum += x}
            sum
        else
            employee_id = Employee.find_by_contact_id(contact_id).id
            time_entries = TimeEntry.find_all_by_project_id_and_employee_id_and_phase_number(self.id, employee_id, phase)
            array = []
            sum = 0
            time_entries.each do |t| 
                array.push(t.entry_total)
            end
            array.map{|x| sum += x}
            sum
        end
    end

    # sum of estimated hours entered for project
    def sum_est
        pd = phase_est('pd') || 0
        sd = phase_est('sd') || 0
        dd = phase_est('dd') || 0
        cd = phase_est('cd') || 0
        bid = phase_est('bid') || 0
        cca = phase_est('cca') || 0
        int = phase_est('int') || 0
        his = phase_est('his') || 0
        add = phase_est('add') || 0
        (pd + sd + dd + cd + bid + cca + int + his + add).to_f
    end   

    # sum of actual hours entered for project
    def sum_actual
        time_entries = TimeEntry.find_all_by_project_id(id)
        array = []
        sum = 0
        time_entries.each do |t| 
            array.push(t.entry_total)
        end
        array.map{|x| sum += x}
        sum.to_f
    end

    def employee_records(contact_id, phase)
        employee_id = Employee.find_by_contact_id(contact_id).id
        TimeEntry.find_all_by_project_id_and_employee_id(self.id, employee_id)
    end



    def budget
        array = []
        sum = 0
        employee_teams.each do |team|
            employee_id = Employee.find_by_contact_id(team.contact_id).id
            rate = DataRecord.find_by_employee_id_and_year(employee_id, Time.now.year).billable_rate
            array.push((team.est_total * rate).to_f)
        end
        array.map{|x| sum += x}
        sum
    end

    def actual
        array = []
        sum = 0
        employee_teams.each do |team|
            array.push(employee_act_costs(team.contact_id, "Total"))
        end
        array.map{|x| sum += x}
        sum
    end

    def employee_est_costs(contact_id, phase)
        if phase == "Total"
            team = EmployeeTeam.find_by_contact_id_and_project_id(contact_id, id)
            employee_id = Employee.find_by_contact_id(contact_id).id
            rate = DataRecord.find_by_employee_id_and_year(employee_id, Time.now.year).billable_rate
            (team.est_total * rate).to_f
        end
    end
    
    def employee_act_costs(contact_id, phase)
        if phase == "Total"
            employee_id = Employee.find_by_contact_id(contact_id).id
            time_entries = TimeEntry.find_all_by_project_id_and_employee_id(self.id, employee_id)

            array = []
            sum = 0
            time_entries.each do |t| 
                year = Timesheet.find(t.timesheet_id).year
                rate = DataRecord.find_by_employee_id_and_year(employee_id, year).billable_rate
                array.push(t.entry_total * rate)
            end
            array.map{|x| sum += x}
            sum
        else
            employee_id = Employee.find_by_contact_id(contact_id).id
            time_entries = TimeEntry.find_all_by_project_id_and_employee_id_and_phase_number(self.id, employee_id, phase)
            array = []
            sum = 0
            time_entries.each do |t| 
                year = Timesheet.find(t.timesheet_id).year
                rate = DataRecord.find_by_employee_id_and_year(employee_id, year).billable_rate
                array.push(t.entry_total * rate)
            end
            array.map{|x| sum += x}
            sum
        end
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

