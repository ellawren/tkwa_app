class ShopDrawing < ActiveRecord::Base
	default_scope order('date_received')

	belongs_to :project
	belongs_to :consultant

	def current_status
		if self.review_status?
			status = "<label class=\"#{label(self.review_status)}\">#{self.review_status}</label>"
		elsif self.date_sent?
			status = "<label class=\"plaintext\">Sent for review on #{self.date_sent}</label>"
		else
			status = "<label class=\"plaintext add-action\">add status</label>"
		end
		"#{status}".html_safe
	end

	def final_action_div
		if self.final_action?
			status = "<label class=\"plaintext\">#{self.final_action}<br>#{self.final_action_date}</label>"
		else
			status = "<label class=\"plaintext add-action\">add action</label>"
		end
		"#{status}".html_safe
	end

	def label(text)
		if text == "Approved"
			"approved" 
		elsif text == "Approved As Noted"
			"as-noted" 
		elsif text == "Revise + Resubmit" 
			"revise" 
		elsif text == "Not Approved" 
			"not-approved" 
		end
	end

end
# == Schema Information
#
# Table name: shop_drawings
#
#  id                :integer         not null, primary key
#  date_received     :string(255)
#  project_id        :integer
#  consultant_id     :integer
#  spec              :string(255)
#  letter            :string(255)
#  description       :string(255)
#  number            :string(255)
#  date_sent         :string(255)
#  date_returned     :string(255)
#  number_sent       :string(255)
#  number_returned   :string(255)
#  final_action_date :string(255)
#  notes             :string(255)
#  review_status     :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  final_action      :string(255)
#

