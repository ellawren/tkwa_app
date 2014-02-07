# == Schema Information
#
# Table name: mailing_lists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class MailingList < ActiveRecord::Base

  	attr_accessible :name, :list_members_attributes

  	has_many :contacts, :through => :list_members
    has_many :list_members, :dependent => :destroy
    accepts_nested_attributes_for :list_members, :allow_destroy => true

end
