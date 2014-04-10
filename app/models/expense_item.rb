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
    default_scope :order => "created_at ASC"
	belongs_to :project
	belongs_to :expense_report
 
 	def date_object
        if self.date
      	    Date.strptime(self.date, "%m/%d/%Y")
        end
  	end

    def food=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:food] = num.to_f
    end

    def parking=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:parking] = num.to_f
    end

    def misc=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:misc] = num.to_f
    end

  	def parent
  		ExpenseReport.find(self.expense_report_id)
  	end
    
    def per_mile
        Global.find_by_year(2014).mileage
    end

  	def mileage_comp
    	if self.miles
    		self.miles * self.per_mile
    	end
    end

    def total
    	self.mileage_comp.to_f +
    	self.food.to_f +
    	self.parking.to_f +
    	self.misc.to_f
    end

end
