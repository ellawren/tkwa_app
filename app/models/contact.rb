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
#

class Contact < ActiveRecord::Base
	has_and_belongs_to_many :categories

  	# allows project page to add items via checkboxes
  	accepts_nested_attributes_for :categories

	validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

    # Get all users that have published a post
  	
    scope :employee, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN categories_contacts ON categories_contacts.contact_id = contacts.id", 
  		:conditions=>"category_id = 7"
	}

	scope :consultant, {
  		:select => "contacts.*",
  		:joins => "INNER JOIN categories_contacts ON categories_contacts.contact_id = contacts.id", 
  		:conditions=>"category_id = 3"
	}


end
