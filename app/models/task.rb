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
#

class Task < ActiveRecord::Base
	default_scope :order => 'name ASC'
	validates :name,  :presence => true,
                    :length   => { :maximum => 30 }
    has_and_belongs_to_many :projects
end

