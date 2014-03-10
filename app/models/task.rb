# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  number      :integer
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  project_id  :integer
#

class Task < ActiveRecord::Base

	validates :name,  :presence => true,
                    :length   => { :maximum => 38 }

    has_and_belongs_to_many :projects

    scope :universal, {
        :select => "tasks.*",
        :conditions => ["project_id IS NULL"],
        :order => ["name"],
    }

    scope :all_project_related, {
        :select => "tasks.*",
        :conditions => ["number IS NULL"],
        :order => ["name"],
    }

    scope :project_tasks, lambda{|l|  where("project_id = ?", l) }
    
end

