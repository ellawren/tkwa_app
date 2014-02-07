# == Schema Information
#
# Table name: list_members
#
#  id              :integer         not null, primary key
#  contact_id      :integer
#  mailing_list_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  name            :string(255)
#

class ListMember < ActiveRecord::Base

	belongs_to :contact
  	belongs_to :mailing_list

  	before_save :update_id_or_name
    def update_id_or_name
    	if self.name?
    		self.contact_id = Contact.find_by_name(self.name).id
    	elsif self.contact_id?
    		self.name = Contact.find(self.contact_id).name
    	end
    end
  
end
