# == Schema Information
#
# Table name: contacts
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  work_title      :string(255)
#  work_department :string(255)
#  work_ext        :string(255)
#  work_direct     :string(255)
#  work_email      :string(255)
#  home_address    :string(255)
#  home_phone      :string(255)
#  home_cell       :string(255)
#  home_email      :string(255)
#  staff_contact   :string(255)
#  notes           :text
#  employee        :boolean         default(FALSE)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  birthday        :string(255)
#  direct_ext      :string(255)
#  work_cell       :string(255)
#  cat_number      :string(255)
#  company_id      :integer
#  work_company    :string(255)
#  work_address    :string(255)
#  work_phone      :string(255)
#  work_url        :string(255)
#  work_fax        :string(255)
#

class Contact < ActiveRecord::Base
  default_scope order('name')

  has_one :employee
  has_one :user, :through => :employee
  accepts_nested_attributes_for :employee

  has_many :projects, :through => :employee_teams

  before_save do
        self.home_phone = self.home_phone.to_s.gsub(/\D/, '')
        self.work_cell = self.work_cell.to_s.gsub(/\D/, '')  
        self.home_cell = self.home_cell.to_s.gsub(/\D/, '') 
        self.work_direct = self.work_direct.to_s.gsub(/\D/, '') 
        self.work_phone = self.work_phone.to_s.gsub(/\D/, '') 
        self.work_fax = self.work_fax.to_s.gsub(/\D/, '') 
  end
              
  scope :consultant_list, {
      :select => "contacts.*",
      :conditions => ["cat_number = ?", "3" ],
  }

  def display_name
    if name.present?
      name
    else
      work_company
    end
  end

  def category
    unless self.cat_number.blank?
      Category.find_by_number(self.cat_number).name
    end
  end

  def associated_projects
    arr = []
    if name.present?
      Project.find_all_by_contact_name(name).each do |p|
        arr.push([p, "Client Contact"])
      end
      Project.find_all_by_billing_name(name).each do |p|
        arr.push([p, "Billing Contact"])
      end
    end
    arr.sort { |a,b| a[0].name <=> b[0].name }
  end

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

end
