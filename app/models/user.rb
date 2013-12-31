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
#  employee_number    :integer
#  contact_id         :integer
#  status             :string(255)
#  hire_date          :string(255)
#  leave_date         :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin, :employee_number, :photo, :delete_photo, :active
  has_attached_file :photo, :styles => { :medium => "210x210#", :thumb => "80x80#"}, :default_url => "generic_avatar_:style.png"
  attr_accessor :delete_photo
  before_validation { photo.clear if delete_photo == '1' }

  default_scope order('name ASC')

  has_secure_password

  has_many :messages, dependent: :destroy
  
  before_save :create_remember_token

  before_create :create_associated_record

  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }

  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? } 
  validates :employee_number, :presence =>true

  # employee_stuff -----------------------------------------------------------------
    has_many :timesheets
    has_many :data_records
    accepts_nested_attributes_for :data_records

    has_many :time_entries, :through => :timesheets
    
    has_many :plan_entries
    accepts_nested_attributes_for :plan_entries, :allow_destroy => true

    has_many :projects, :through => :employee_teams
    has_many :employee_teams, :dependent => :destroy
    # allows project page to add employees via team join model. must allow destroy.
    accepts_nested_attributes_for :employee_teams, :allow_destroy => true

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

    #def employee_forecast(project_id, four_month_array)
    #    entries = []
    #    four_month_array.each do |w, y|
    #        entries.push(PlanEntry.find_or_create_by_project_id_and_employee_id_and_year_and_week(project_id, self.id, y, w))
    #    end
    #    entries
    #end

    #def forecast_week_total(four_month_array)
    #    x = []
    #    four_month_array.each do |w, y|
    #        plan_entries = PlanEntry.find_all_by_employee_id_and_year_and_week(self.id, y, w)
    #        array = []
    #        sum = 0
    #        plan_entries.each do |e|
    #            if e.hours?
    #                array.push(e.hours)
    #            end
    #        end
    #       array.map{|x| sum += x}
    #        if sum == 0
    #            x.push("")
    #        else
    #            x.push(sum)
    #        end
    #    end
    #    x
    #end
  # -------------------------------------------------------------------------------

  scope :active_users, {
        :select => "users.*",
        :conditions => ["active = ?", true ]
    }

  scope :inactive_users, {
        :select => "users.*",
        :conditions => ["active = ?", false ]
    }

  def create_associated_record
    # create the associated contact object
    contact = Contact.create( :name => name, 
                              :work_company => "The Kubala Washatko Architects, Inc.",
                              :work_address => "W61 N617 Mequon Avenue\nCedarburg, WI 53012",
                              :work_phone => "(262) 377-6039",
                              :work_fax => "(262) 377-2954",
                              :work_url => "www.tkwa.com",
                              :work_email => email,
                              :cat_number => 7
                            )
    # set the join id of the new contact object
    self.contact_id = contact.id
    self.status = "Current"
    self.hire_date = Date.today
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
