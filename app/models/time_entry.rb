# == Schema Information
#
# Table name: time_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  project_id   :integer
#  date         :date
#  hours        :decimal(6, 2)
#  phase        :string(255)
#  task         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class TimeEntry < ActiveRecord::Base
  default_scope :order => 'date ASC'
  
  belongs_to :timesheet
  belongs_to :project
  
  validates_presence_of :date
  validates_presence_of :phase, :message => "must be selected"
  validates_numericality_of :hours,
    :greater_than => 0, :less_than_or_equal_to => 24

  PHASES =   [	"Predesign", "Schematic", "Design Dev", "Const Docs", "Bidding",
	    		"CCA", "Interior", "Historic", "Additional" ]

end

