# == Schema Information
#
# Table name: contacts
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  work_title      :string(255)
#  work_company    :string(255)
#  work_department :string(255)
#  work_address    :string(255)
#  work_phone      :string(255)
#  work_ext        :string(255)
#  work_assistant  :string(255)
#  work_direct     :string(255)
#  work_fax        :string(255)
#  work_email      :string(255)
#  work_url        :string(255)
#  home_address    :string(255)
#  home_phone      :string(255)
#  home_cell       :string(255)
#  home_email      :string(255)
#  staff_contact   :string(255)
#  notes           :text
#  employee        :boolean         default(FALSE)
#  category        :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  birthday        :string(255)
#  direct_ext      :string(255)
#  assistant       :string(255)
#  work_cell       :string(255)
#  post_nominals   :string(255)
#  prefix          :string(255)
#  cat01           :string(255)
#  cat02           :string(255)
#  cat03           :string(255)
#  cat04           :string(255)
#  cat05           :string(255)
#  cat06           :string(255)
#  view_options    :string(255)     default("---\n- name\n- work\n- personal\n")
#

class Contact < ActiveRecord::Base
  default_scope order('name')
	has_and_belongs_to_many :categories

  has_one :employee
  has_one :user, :through => :employee
  accepts_nested_attributes_for :employee

  # allows project page to add items via checkboxes
  accepts_nested_attributes_for :categories

  has_many :projects, :through => :employee_teams
  has_many :employee_teams, :dependent => :destroy
  # allows project page to add employees via team join model. must allow destroy.
  accepts_nested_attributes_for :employee_teams, :allow_destroy => true

	validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  before_save do
        self.work_phone = self.work_phone.to_s.gsub(/\D/, '') 
        self.home_phone = self.home_phone.to_s.gsub(/\D/, '')
        self.work_cell = self.work_cell.to_s.gsub(/\D/, '')  
        self.work_fax = self.work_fax.to_s.gsub(/\D/, '')  
        self.home_cell = self.home_cell.to_s.gsub(/\D/, '') 
        self.work_direct = self.work_direct.to_s.gsub(/\D/, '') 
        self.category = self.category_list
  end


  scope :non_employees, where("id NOT IN (SELECT contact_id FROM employees)")

  scope :employee_list, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN employees ON employees.contact_id = contacts.id", 
  		:conditions => ["status = ?", 'Current' ]
	}


	scope :consultant_list, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN categories_contacts ON categories_contacts.contact_id = contacts.id", 
  		:conditions =>"category_id = 3"
  }

  scope :by_category, (lambda do |id| 
        { :select => "contacts.*",
        :joins => "INNER JOIN categories_contacts ON categories_contacts.contact_id = contacts.id", 
        :conditions => ['category_id = ?', id]

      } unless id.empty?
  end)

  VIEW_OPTIONS =       [ "name", "work", "personal" ]

  def project_list
    arr = []
    self.employee_teams.current.each do |team|
      arr.push(Project.find(team.project_id))
    end
    arr.sort { |a,b| a.name <=> b.name }
  end

  CONTACT_CATEGORIES =   [  "Client", "Consultant", "Contractor", "Supplier", "Architect",
              "Marketing", "Employee"
             ]

def category_array
      arr = []
        unless self.cat01.blank?
            arr.push(Category.find(self.cat01).name)
        end
        unless self.cat02.blank?
            arr.push(Category.find(self.cat02).name)
        end
        unless self.cat03.blank?
            arr.push(Category.find(self.cat03).name)
        end
        unless self.cat04.blank?
            arr.push(Category.find(self.cat04).name)
        end
        unless self.cat05.blank?
            arr.push(Category.find(self.cat05).name)
        end
        unless self.cat06.blank?
            arr.push(Category.find(self.cat06).name)
        end
      arr
  end

  def category_list
    unless self.category_array.count == 0
      self.category_array.map { |t| t }.join(", ")
    end
  end

  def category_page_links
    list = []
    id = self.id.to_s
    self.category_array.each do |c|
      list.push("<li><a href='/contacts/" + id + "/data?" + c + "'>" + c + " data</a></li>")
    end
    list.join.html_safe

  end


end
