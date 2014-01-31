class ExpenseReport < ActiveRecord::Base
  	attr_accessible :complete, :date, :description, :food, :miles, :misc, :parking, :project_id, :user_id, :year
  	belongs_to :user

  	def date_object
      	Date.strptime(self.date, "%m/%d/%Y")
  	end

  	before_save :year_parse
    def year_parse
    	self.year = date_object.year
    end
end
# == Schema Information
#
# Table name: expense_reports
#
#  id          :integer         not null, primary key
#  user_id     :integer         not null
#  date        :string(255)
#  project_id  :integer
#  description :string(255)
#  miles       :integer
#  food        :decimal(5, 2)
#  parking     :decimal(5, 2)
#  misc        :decimal(5, 2)
#  complete    :boolean         default(FALSE)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  year        :integer
#

