class Vacation < ActiveRecord::Base
	default_scope :order => "start_date ASC"
  	attr_accessible :end_date, :hours, :start_date, :user_id
  	belongs_to :user

  	def date_object
      	Date.strptime(self.start_date, "%m/%d/%Y")
  	end

  	before_save :year_parse
    def year_parse
    	self.year = date_object.year
    end

end
# == Schema Information
#
# Table name: vacations
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  start_date :string(255)
#  end_date   :string(255)
#  hours      :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  year       :integer
#

