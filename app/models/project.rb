# == Schema Information
#
# Table name: projects
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  number                :string(255)
#  location              :string(255)
#  client                :string(255)
#  client_type           :string(255)
#  status                :string(255)     default("current")
#  contact_name          :string(255)
#  contact_phone         :string(255)
#  contact_email         :string(255)
#  billing_name          :string(255)
#  billing_address       :string(255)
#  billing_phone         :string(255)
#  billing_email         :string(255)
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  billing_ext           :string(255)
#  contact_ext           :string(255)
#  start_date            :string(255)
#  completion_date       :string(255)
#  pd_start              :date
#  pd_end                :date
#  sd_start              :date
#  sd_end                :date
#  dd_start              :date
#  dd_end                :date
#  cd_start              :date
#  cd_end                :date
#  bid_start             :date
#  bid_end               :date
#  cca_start             :date
#  cca_end               :date
#  add_start             :date
#  add_end               :date
#  pd_percent            :integer
#  sd_percent            :integer
#  dd_percent            :integer
#  cd_percent            :integer
#  bid_percent           :integer
#  cca_percent           :integer
#  his_percent           :integer
#  int_percent           :integer
#  add_percent           :integer
#  client_url            :string(255)
#  contract_amount       :decimal(12, 2)
#  payroll               :decimal(12, 2)
#  alt_contact           :string(255)
#  mkt_location          :string(255)
#  mkt_size              :string(255)
#  mkt_cost              :string(255)
#  mkt_description       :text
#  mkt_reference         :string(255)
#  mkt_status            :string(255)
#  view_options          :string(255)     default("---\n- setup\n- scope\n- forecast\n- tracking\n- billing\n")
#  proposal_date         :string(255)
#  interview_date        :string(255)
#  awarded               :string(255)     default("pending")
#  contact_address       :string(255)
#  billed_to_date        :decimal(12, 2)
#  hourly_billed_to_date :decimal(12, 2)
#  recent_billing        :boolean         default(FALSE)
#  cm                    :string(255)
#  building_type_id      :integer
#  billing_type_id       :integer
#

class Project < ActiveRecord::Base

    has_many :users, :through => :employee_teams
    has_many :employee_teams, :dependent => :destroy
    accepts_nested_attributes_for :employee_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:user_id].blank? || a[:role].blank? }

    has_many :consultant_teams, :dependent => :destroy
    accepts_nested_attributes_for :consultant_teams, :allow_destroy => true, :reject_if => lambda { |a| a[:consultant_name].blank? }

    has_many :bills, :through => :consultant_teams

    has_many :patterns 
    accepts_nested_attributes_for :patterns, :allow_destroy => true

    has_many :schedule_items
    accepts_nested_attributes_for :schedule_items, :allow_destroy => true

    has_many :plan_entries, :dependent => :destroy
    accepts_nested_attributes_for :plan_entries, :allow_destroy => true

    has_many :time_entries

    has_many :shop_drawings
    accepts_nested_attributes_for :shop_drawings, :allow_destroy => true, :reject_if => lambda { |a| a[:date_received].blank? }

    has_many :actuals, :dependent => :destroy
    accepts_nested_attributes_for :actuals, :allow_destroy => true

    has_many :unassigned_hours, :dependent => :destroy
    accepts_nested_attributes_for :unassigned_hours

    has_and_belongs_to_many :services
    has_and_belongs_to_many :reimbursables
    has_and_belongs_to_many :consultant_roles
    has_and_belongs_to_many :phases
    has_many :tasks # do not use has_and_belongs_to_many, even though this is technically true - this line ONLY applies to the project-specific tasks and add/delete will get messed up

    has_many :expense_items # this doesn't really matter since it's not ever called upon

    # allows project page to add items via checkboxes
    accepts_nested_attributes_for :services
    accepts_nested_attributes_for :reimbursables
    accepts_nested_attributes_for :consultant_roles
    accepts_nested_attributes_for :phases
    accepts_nested_attributes_for :tasks, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? } # need to allow delete of project-specific tasks

	validates :name, presence: true
    validates :number, :uniqueness => true, :presence => true, if: lambda { |p| p.try(:status) != 'potential' }
    validates :status, presence: true

    # set default phase values
    before_create :phase_values
    def phase_values
        self.phase_ids = [1, 2, 3, 4, 5, 6, 7, 9]
    end

    # default to 'current' status if not set, and fill in a number for a potential project so it doesn't throw an error
    before_save :default_values
    def default_values
        self.status ||= 'current'
        if self.status == 'potential'
            self.number = "000000"
        end
    end

    # check for recent billing and mark as true to add project to Leta's Monthly Billing view
    after_save :set_billing
    def set_billing
        if self.recent_billing == false && self.actual_array_sum > 0
            self.recent_billing = true
            self.save
        elsif self.recent_billing == true && self.actual_array_sum == 0
            self.recent_billing = false
            self.save
        end
    end

    scope :with_patterns, {
        :select => "DISTINCT projects.*",
        :joins => "INNER JOIN patterns ON patterns.project_id = projects.id",
        :order => ["name ASC" ]
    }

    scope :all_projects, {
        :select => "projects.*",
        :conditions => ["status != ?", 'potential' ]
    }

    scope :potential_projects, {
        :select => "projects.*",
        :conditions => ["status = ? AND awarded = ?", 'potential', 'pending' ]
    }

    scope :past_potential_projects, {
        :select => "projects.*",
        :conditions => ["awarded = ? OR awarded = ?", 'yes', 'no' ]
    }

    scope :current, {
        :select => "projects.*",
        :conditions => ["status = ?", 'current' ],
        :order => ["name ASC" ]
    }

    scope :current_and_potential, {
        :select => "projects.*",
        :conditions => ["status = ? OR status = ? AND awarded != ?", 'current', 'potential', 'no' ],
        :order => ["name ASC" ]
    }

    scope :current_and_billing, {
        :select => "projects.*",
        :conditions => ["status = ? OR recent_billing = ?", 'current', true ],
        :order => ["name ASC" ]
    }

    scope :alpha, {
        :select => "projects.*",
        :order => ["name ASC" ]
    }

    scope :related_projects, lambda{|l|  where("number LIKE :l", l: "#{l}%")}

    # next/prev
    #scope :next, lambda {|id| where("status = ? AND number > ?", "current", id).order("number ASC") }
    #scope :previous, lambda {|id| where("status = ? AND number < ?", "current", id).order("number DESC") }
    scope :next, lambda {|id| where("id > ?", id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?", id).order("id DESC") }

    def next
        #Project.next(self.number).first
        Project.next(self.id).first
    end

    def previous
        #Project.previous(self.number).first
        Project.previous(self.id).first
    end
    #------------------------------------

    def number_base
        /\A\d*/.match(self.number)
    end

    def user_ids
        self.employee_teams.current.pluck(:user_id)
    end

    def user_list
        User.active_users.where('id IN (?)', user_ids).order("name")
    end

    def not_on_user_list
        if user_ids.count > 0
            User.active_users.where('id NOT IN (?)', user_ids).order("name")
        else
            User.active_users.order("name")
        end
    end


# SCOPE #######################################################################

    def available_phases
        a = []
        self.phase_ids.each do |t|
          a.push(Phase.find(t))
        end
        a
    end

    def available_tasks
        available_tasks = []
        Task.universal.each do |t|
          available_tasks.push(t)
        end
        Task.project_tasks(self.id).each do |t|
          available_tasks.push(t)
        end
        available_tasks
    end


# BILLING #######################################################################

    def contract_amount=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:contract_amount] = num.to_f
    end

    def payroll=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:payroll] = num.to_f
    end

    def hourly_billed_to_date=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:hourly_billed_to_date] = num.to_f
    end

    def billed_to_date=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:billed_to_date] = num.to_f
    end

    def tkwa_fee
        (self.contract_amount.to_f + self.hourly_billed_to_date.to_f) - self.consultant_contract_total.to_f
    end

    def actuals_list
        Actual.by_project(self.id).order("year ASC, month ASC")
    end

    def consultant_contract_total
        sum = 0
        self.consultant_teams.each do |c| 
            sum += c.consultant_contract.to_f
        end
        sum
    end

    def current_profit
        if tkwa_fee && payroll
            ( tkwa_fee.to_f - payroll.to_f )
        end
    end

    def percent_billed_to_date
        if billed_to_date && contract_amount
            if billed_to_date == 0 || contract_amount == 0
                0
            else
                ( billed_to_date / contract_amount ) * 100
            end
        end
    end

    def project_bills_total
        #initialize empty bill array and sum
        bill_array = []
        sum = 0

        #for each consultant team, create array of bills and add to master array
        consultant_teams.each do |t| 
            bills = Bill.where(consultant_team_id: t.id)
            bills.each do |b|
                sum += b.amount
            end
        end
        sum
    end

    def consultant_percent_billed
      if consultant_contract_total.present? && project_bills_total.present?
        unless consultant_contract_total == 0 || project_bills_total == 0
            ( project_bills_total.to_f / consultant_contract_total.to_f ) * 100
        end
      end
    end

    def actual_array
        date = Date.today.beginning_of_month
        array = []
        (1..5).each do |m| 
            array.push(Actual.where(project_id: self.id, year: date.year, month: date.month).first_or_create) 
            date = date - 1.month
        end
        array
    end

    def actual_array_sum
        array = []
        sum = 0
        if self.actuals.count > 0
            self.actual_array.each do |a|
                sum += a.amount
            end
            sum
        else
            0
        end
    end


# TRACKING #######################################################################


    # HOURS

    def total_target_hours(phase)
        employee_teams.sum(phase+'_hours')
    end

    def total_target_hours_all
        sum = 0
        available_phases.each do |phase|
            sum += total_target_hours(phase.shorthand).to_f
        end
        sum.to_f
    end

    def total_actual_hours(phase)
        self.time_entries.where(:phase_number => phase).sum(:total)
    end

    def total_actual_hours_all
        self.time_entries.sum(:total)
    end

    # FEES

    def total_actual_fees(phase_number)
        sum = 0
        employee_teams.map{|e| sum += e.employee_actual_fees(phase_number)}
        sum
    end

    def total_actual_fees_all
        employee_teams.sum(&:employee_actual_fees_all)
    end

    def total_target_fees(phase_shorthand)
        sum = 0
        employee_teams.map{|e| sum += e.employee_target_fees(phase_shorthand)}
        sum
    end

    def total_target_fees_all
        employee_teams.sum(&:employee_target_fees_all)
    end

    def percentage_of_total(phase_number)
        total_actual_fees(phase_number) / total_target_fees_all unless total_target_fees_all == 0
    end

    def percentage_of_total_all
        total_actual_fees_all / total_target_fees_all unless total_target_fees_all == 0
    end

    def percent_used
        if total_target_fees_all
            (total_actual_fees_all / total_target_fees_all) * 100
        end
    end


# FORECAST #######################################################################

    def employee_forecast(user_id, four_month_array)
        entries = []
        four_month_array.each do |w, y|
            entries.push(PlanEntry.where(project_id: self.id, user_id: user_id, year: y, week: w).first_or_create)
        end
        entries
    end

    def forecast_total(w, y)
        PlanEntry.current.where(:project_id => self.id, :week => w, :year => y).sum(:hours).to_i + UnassignedHour.find_or_create_by_project_id_and_week_and_year(self.id, w, y).hours.to_i
    end

    def unassigned_nonblank
        UnassignedHour.active.where("project_id = ? and hours > ?", self.id, 0)
    end

    def unassigned_by_week(w,y)
        UnassignedHour.where(:project_id => self.id, :week => w, :year => y).sum(:hours)
    end


# SCHEDULE #######################################################################

    def schedule_item_list(phase)
        p = Phase.find(phase).id
        items = []
        self.schedule_items.each do |item|
            if item.phase_id == phase
                items.push(item)
            end
        end
        items
    end

    def schedule
        gantt = []
        self.available_phases.each do |p|
            unless self.schedule_item_list(p.id).empty?
                phase_start = self.schedule_item_list(p.id).first.start

                arr = []
                    self.schedule_item_list(p.id).each do |s| 
                    arr.push(Date.strptime(s.end, "%m/%d/%Y")) 
                end
                phase_end = arr.sort.last.strftime("%m/%d/%Y")
                
                    # calculation phase duration
                    days = ( DateTime.strptime(phase_end, "%m/%d/%Y") - DateTime.strptime(phase_start, "%m/%d/%Y") ).to_f
                    y = (days / 365.25).floor 
                    m = ( ( days - (y*365.25) ) / 30.4).floor
                    w = ( ( ( days - (y*365.25) ) - (m*30.4) ) / 7).floor
                    d = ( days - (y*365.25) - (m*30.4) - (w*7) ).floor
                    full_date = []
                    if y == 1 then years = "#{y} year" elsif y > 1 then years = "#{y} years" end
                        if years then full_date.push(years) end
                    if m == 1 then months = "#{m} month" elsif m > 1 then months = "#{m} months" end
                        if months then full_date.push(months) end
                    if y == 0
                        if w == 1 then weeks = "#{w} week" elsif w > 1 then weeks = "#{w} weeks" end
                            if weeks then full_date.push(weeks) end
                        if m == 0
                            if d == 1 then days = "#{d} day" elsif d > 1 then days = "#{d} days" end
                                if days then full_date.push(days) end
                        end
                    end
                    # end block

                    duration = full_date.join(", ")
                    # this is the phase bar
                    gantt.push("{ name: \"\", desc: \"#{p.full_name}\" , id: \"phase\", p_id: \"\", values: [{ id: \"\", from: \"/Date(#{(DateTime.strptime(phase_start, "%m/%d/%Y").to_f*1000).ceil})/\", to: \"/Date(#{(DateTime.strptime(phase_end, "%m/%d/%Y").to_f*1000).ceil})/\", label: \"#{p.full_name}\", customClass: \"gantt-#{p.shorthand} phase\", dep: \"\", dataObj: {myTitle: \"<div class='pop-title gantt-#{p.shorthand}'>#{p.full_name}</div>\", myContent: \"<div class='pop-label gantt-#{p.shorthand}'>Start Date:</div>#{phase_start}<br><div class='pop-label gantt-#{p.shorthand}'>End Date:</div>#{phase_end}<br><div class='pop-label gantt-#{p.shorthand}'>Duration:</div>#{duration}\", myID: \"phase\" }}] }")
                    self.schedule_item_list(p.id).each_with_index do |item, index|
                    unless item.start.blank? || item.end.blank?
                        # these are the individual item bars
                        gantt.push("{ name: \"\", desc: \"#{item.desc}\" , id: \"#{item.id}\", p_id: \"#{item.project_id}\", values: [{ id: \"#{item.id}\", from: \"/Date(#{(DateTime.strptime(item.start, "%m/%d/%Y").to_f*1000).ceil})/\", to: \"/Date(#{(DateTime.strptime(item.end, "%m/%d/%Y").to_f*1000).ceil})/\", label: \"#{item.desc}\", customClass: \"gantt-#{Phase.find(item.phase_id).shorthand} #{item.meeting}\", dep: \"\", dataObj: {myTitle: \"<div class='pop-title gantt-#{Phase.find(item.phase_id).shorthand} #{item.meeting}'>#{item.desc}</div>\", myContent: \"<div class='pop-label gantt-#{Phase.find(item.phase_id).shorthand} #{item.meeting}'>Start Date:</div>#{item.start}<br><div class='pop-label gantt-#{Phase.find(item.phase_id).shorthand} #{item.meeting}'>End Date:</div>#{item.end}<br><div class='pop-label gantt-#{Phase.find(item.phase_id).shorthand} #{item.meeting}'>Duration:</div>#{item.duration}\", myID: \"#{item.id}\" }}] }")
                    end
                end
            end
        end
        gantt.join(", ").html_safe
    end

    def schedule_collapsed
        gantt = []
        self.available_phases.each do |p|
            unless self.schedule_item_list(p.id).empty?
                phase_start = self.schedule_item_list(p.id).first.start

                arr = []
                    self.schedule_item_list(p.id).each do |s| 
                    arr.push(Date.strptime(s.end, "%m/%d/%Y")) 
                end
                phase_end = arr.sort.last.strftime("%m/%d/%Y")
                
                    # calculation phase duration
                    days = ( DateTime.strptime(phase_end, "%m/%d/%Y") - DateTime.strptime(phase_start, "%m/%d/%Y") ).to_f
                    y = (days / 365.25).floor 
                    m = ( ( days - (y*365.25) ) / 30.4).floor
                    w = ( ( ( days - (y*365.25) ) - (m*30.4) ) / 7).floor
                    d = ( days - (y*365.25) - (m*30.4) - (w*7) ).floor
                    full_date = []
                    if y == 1 then years = "#{y} year" elsif y > 1 then years = "#{y} years" end
                        if years then full_date.push(years) end
                    if m == 1 then months = "#{m} month" elsif m > 1 then months = "#{m} months" end
                        if months then full_date.push(months) end
                    if y == 0
                        if w == 1 then weeks = "#{w} week" elsif w > 1 then weeks = "#{w} weeks" end
                            if weeks then full_date.push(weeks) end
                        if m == 0
                            if d == 1 then days = "#{d} day" elsif d > 1 then days = "#{d} days" end
                                if days then full_date.push(days) end
                        end
                    end
                    # end block

                    duration = full_date.join(", ")

                    gantt.push("{ name: \"\", desc: \"#{p.full_name}\" , id: \"phase\", p_id: \"\", values: [{ id: \"\", from: \"/Date(#{(DateTime.strptime(phase_start, "%m/%d/%Y").to_f*1000).ceil})/\", to: \"/Date(#{(DateTime.strptime(phase_end, "%m/%d/%Y").to_f*1000).ceil})/\", label: \"#{p.full_name}\", customClass: \"gantt-#{p.shorthand}\", dep: \"\", dataObj: {myTitle: \"<div class='pop-title gantt-#{p.shorthand}'>#{p.full_name}</div>\", myContent: \"<div class='pop-label gantt-#{p.shorthand}'>Start Date:</div>#{phase_start}<br><div class='pop-label gantt-#{p.shorthand}'>End Date:</div>#{phase_end}<br><div class='pop-label gantt-#{p.shorthand}'>Duration:</div>#{duration}\", myID: \"19\" }}] }")
            end
        end
        gantt.join(", ").html_safe
    end

    #######################################################################

    # do not change the order on these - it will affect all previous records
    BUILDING_TYPES = [	"Condos", "Educational", "Financial", "HD Dealership", "Historic Restoration", 
    					"Hospitality", "Industrial", "Library", "Maintenance", "Manufacturing",
    					"Medical Elderly", "Medical Clinic", "Medical Hospital", "Mixed Use", 
    					"Municipal", "Museum", "Offices", "Performing Arts", "Planning", 
    					"Recreation", "Religious", "Residential Single", "Residential Multi",
    					"Retail", "Sustainable Design", "Teaching", "Urban Design"
    				 ]
    
    BILLING_TYPES =  [ "% of Const. Cost", "Lump Sum", "Lump Sum With Extras", "Hourly - No Maximum", "Hourly - NTE", "Hourly With Extras", "Hourly NTE With Extras" ]

    VIEW_OPTIONS =  [ 'tracking', 'forecast', 'schedule', 'shop drawings', 'patterns', 'marketing' ]

end
