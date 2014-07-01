# == Schema Information
#
# Table name: patterns
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  issue                :text
#  solution             :text
#  author               :string(255)
#  background           :text
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  project_id           :integer
#  number               :integer
#  rating               :integer
#  authors              :string(255)
#  challenges           :text
#  approval             :string(255)
#  diagram_file_name    :string(255)
#  diagram_content_type :string(255)
#  diagram_file_size    :integer
#  diagram_updated_at   :datetime
#  photo_file_name      :string(255)
#  photo_content_type   :string(255)
#  photo_file_size      :integer
#  photo_updated_at     :datetime
#  pattern_group_id     :integer
#

class Pattern < ActiveRecord::Base
	
	default_scope order('project_id DESC, number ASC')
	belongs_to :project

	has_attached_file :diagram, :styles => { :large => "600x600>", :medium => "300x300#", :thumb => "200x200#" }
	has_attached_file :photo, :styles => { :large => "600x600>", :medium => "300x300#", :thumb => "200x200#" }

	attr_accessor :delete_diagram, :delete_photo
	before_validation { diagram.clear if delete_diagram == '1' }
	before_validation { photo.clear if delete_photo == '1' }

	# next/prev
    #scope :next, lambda {|id| where("status = ? AND number > ?", "current", id).order("number ASC") }
    #scope :previous, lambda {|id| where("status = ? AND number < ?", "current", id).order("number DESC") }
    scope :next, lambda {|id| where("number > ?", number).order("number ASC") }
    scope :previous, lambda {|id| where("number < ?", number).order("number DESC") }

    def next
        #Project.next(self.number).first
        Pattern.next(self.number).first
    end

    def previous
        #Project.previous(self.number).first
        Pattern.previous(self.number).first
    end
    #------------------------------------

end
