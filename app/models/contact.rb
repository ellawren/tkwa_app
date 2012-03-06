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
#  birthday        :date
#  direct_ext      :string(255)
#  assistant       :string(255)
#  work_cell       :string(255)
#

class Contact < ActiveRecord::Base
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

  

  scope :non_employees, where("id NOT IN (SELECT contact_id FROM employees)")

  scope :employee_list, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN employees ON employees.contact_id = contacts.id", 
  		:conditions => ["status = ?", 'Current' ]
	}


	scope :consultant_list, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN categories_contacts ON categories_contacts.contact_id = contacts.id", 
  		:conditions =>"category_id = 3",
}




end
