# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)     default(""), not null
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  admin              :boolean         default(FALSE)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean         default(TRUE)
#  remember_token     :string(255)
#  password_digest    :string(255)
#

class User < ActiveRecord::Base

    has_attached_file :photo, :styles => { :medium => "210x210#", :thumb => "80x80#"}, :default_url => "generic_avatar_:style.png"
    attr_accessor :delete_photo
    before_validation { photo.clear if delete_photo == '1' }

    has_secure_password

    has_one :employee, :dependent => :destroy
    has_one :contact, :through => :employee
    accepts_nested_attributes_for :contact

    before_save :create_remember_token

    after_initialize do
        if self.employee.blank?
            # find or create the associated contact model
            contact = Contact.find_or_create_by_name(self.name)
                contact.work_company = "The Kubala Washatko Architects, Inc."
                contact.work_address = "W61 N617 Mequon Avenue\nCedarburg, WI 53012"
                contact.work_phone = "(262) 377-6039"
                contact.work_fax = "(262) 377-2954"
                contact.work_url = "www.tkwa.com"
                contact.work_email = email
                contact.cat_number = 7
            # create the employee join model
            employee = self.build_employee
                employee.contact_id = contact.id
                employee.user_id = self.id
            employee.save        
        end
    end

    # SCOPES
    default_scope order('name ASC')

    scope :active_users, {
        :select => "users.*",
        :conditions => ["active = ?", true ]
    }

    scope :inactive_users, {
        :select => "users.*",
        :conditions => ["active = ?", false ]
    }
    
    # VALIDATIONS
    validates :name, presence: true, length: { maximum: 50 }
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }

    validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
    validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? } 

    # ASSOCIATIONS
    has_many :timesheets
    has_many :time_entries, :through => :timesheets

    has_many :data_records, :dependent => :destroy
    accepts_nested_attributes_for :data_records

    has_many :vacation_records, :dependent => :destroy
    accepts_nested_attributes_for :vacation_records

    has_many :plan_entries, :dependent => :destroy
    accepts_nested_attributes_for :plan_entries, :allow_destroy => true

    has_many :messages, dependent: :destroy

    has_many :vacations, dependent: :destroy, :conditions => { :year => Date.today.cwyear }
    accepts_nested_attributes_for :vacations, :allow_destroy => true

    has_many :expense_reports, dependent: :destroy
    accepts_nested_attributes_for :expense_reports, :allow_destroy => true
    
    has_many :employee_teams, :dependent => :destroy
    has_many :projects, :through => :employee_teams
    accepts_nested_attributes_for :employee_teams, :allow_destroy => true

    # METHODS
    def project_list
        arr = []
        self.employee_teams.current.each do |team|
          arr.push(Project.find(team.project_id))
        end
        arr.sort { |a,b| a.name <=> b.name }
    end

    def project_ids
        arr = []
        self.project_list.each do |team|
          arr.push(team.id)
        end
        arr
    end

    def employee_forecast(project_id, four_month_array)
        entries = []
        four_month_array.each do |w, y|
            entries.push(PlanEntry.current.find_or_create_by_project_id_and_user_id_and_year_and_week(project_id, self.id, y, w))
        end
        entries
    end

    def forecast_total(w, y)
        plan_entries = PlanEntry.current.find_all_by_user_id_and_year_and_week(self.id, y, w)
        array = []
        sum = 0
        plan_entries.each do |e|
            if e.hours?
                array.push(e.hours)
            end
        end
        array.map{|x| sum += x}
        if sum == 0
            x = ""
        else
            x = sum
        end
        x
    end

    def link_name
        if admin?
          name + " (Admin)"
        else
          name
        end
    end
  
    private

        def create_remember_token
          self.remember_token = SecureRandom.urlsafe_base64
        end
    
end
