# == Schema Information
#
# Table name: expense_items
#
#  id                :integer         not null, primary key
#  expense_report_id :integer
#  project_id        :integer
#  date              :string(255)
#  description       :string(255)
#  miles             :integer
#  food              :decimal(6, 2)
#  parking           :decimal(6, 2)
#  misc              :decimal(6, 2)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#


class ExpenseItem < ActiveRecord::Base

	belongs_to :project
	belongs_to :expense_report
 
 	def date_object
      	Date.strptime(self.date, "%m/%d/%Y")
  	end

  	def parent
  		ExpenseReport.find(self.expense_report_id)
  	end

  	def mileage_comp
    	if self.miles
    		self.miles * Global.find_by_year(parent.year).mileage
    	end
    end

    def total
    	self.mileage_comp.to_f +
    	self.food.to_f +
    	self.parking.to_f +
    	self.misc.to_f
    end

end
