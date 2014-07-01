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
#  notes                :text
#  project_name         :string(255)
#

class Pattern < ActiveRecord::Base
	
	belongs_to :project

	has_attached_file :diagram, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "200x200>" }
	has_attached_file :photo, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "200x200>" }

	attr_accessor :delete_diagram, :delete_photo
	before_validation { diagram.clear if delete_diagram == '1' }
	before_validation { photo.clear if delete_photo == '1' }

	# next/prev
    #scope :next, lambda {|id| where("number > ?", number).order("number ASC") }
    #scope :previous, lambda {|id| where("number < ?", number).order("number DESC") }
    scope :next, lambda {|id| where("id > ?", id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?", id).order("id DESC") }

    def next
        #Pattern.next(self.number).first
        Pattern.next(self.id).first
    end

    def previous
        #Pattern.previous(self.number).first
        Pattern.previous(self.id).first
    end
    #------------------------------------

    scope :by_project, {
        :select => "patterns.*",
        :order => ["project_id DESC, number ASC" ]
   }

    before_save do
        if self.project_name.present?
            self.project_id = Project.find_by_name(self.project_name).id
        end
    end

end
