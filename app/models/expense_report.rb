# == Schema Information
#
# Table name: expense_reports
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  complete   :boolean         default(FALSE)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  year       :integer
#

class ExpenseReport < ActiveRecord::Base
	
	default_scope :order => "date ASC"

  	belongs_to :user

    has_many :expense_items, dependent: :destroy
    accepts_nested_attributes_for :expense_items, :allow_destroy => true

  	before_save do
    	self.year = self.created_at.year
    end

end
