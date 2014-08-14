# == Schema Information
#
# Table name: list_members
#
#  id              :integer         not null, primary key
#  contact_id      :integer
#  mailing_list_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  contact_name    :string(255)
#

class ListMember < ActiveRecord::Base

    # can't figure out why the usual default order by contact_name isn't working here, but the does work
    scope :ordered, {
        :select => "list_members.*",
        :joins => "INNER JOIN contacts ON list_members.contact_id = contacts.id", 
        :order => "contacts.name"
    }

	belongs_to :contact
  	belongs_to :mailing_list

  	before_save :update_id_or_name
    def update_id_or_name
    	if self.contact_name?
    		self.contact_id = Contact.where(name: self.contact_name).first.id
    	elsif self.contact_id?
    		self.contact_name = Contact.find(self.contact_id).name
    	end
    end
  
end
