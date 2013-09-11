class Company < ActiveRecord::Base
	default_scope order('name')
	
	has_many :contacts

	scope :consultant_list, {
  		:select => "companies.*",
  		:conditions => ["category = ?", '3' ]
	}

	before_save do
        self.phone = self.phone.to_s.gsub(/\D/, '') 
        self.fax = self.fax.to_s.gsub(/\D/, '')
  	end

	COMPANY_CATEGORIES =   [  "Client", "Consultant", "Contractor", "Supplier", "Architect"
             ]
end
# == Schema Information
#
# Table name: companies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  fax        :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  category   :string(255)
#

