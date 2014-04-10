# == Schema Information
#
# Table name: expense_reports
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  complete   :boolean         default(FALSE)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  printed    :boolean         default(FALSE)
#

class ExpenseReport < ActiveRecord::Base
	
	default_scope :order => "created_at ASC"

  	belongs_to :user

    has_many :expense_items, dependent: :destroy
    accepts_nested_attributes_for :expense_items, :allow_destroy => true, :reject_if => lambda { |a| a[:date].blank? }

    def total
    	ExpenseItem.where(expense_report_id: self.id).sum(&:total)
    end

end
