# == Schema Information
#
# Table name: bills
#
#  id                 :integer         not null, primary key
#  date               :string(255)
#  amount             :decimal(, )
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  consultant_team_id :integer         not null
#  invoice_number     :string(255)
#  date_approved      :string(255)
#

class Bill < ActiveRecord::Base

    default_scope order('created_at')
	belongs_to :consultant_team

end
