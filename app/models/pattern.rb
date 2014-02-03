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
#  group                :string(255)
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
#

class Pattern < ActiveRecord::Base
	
	default_scope order('project_id DESC, number ASC')
	belongs_to :project

	has_attached_file :diagram, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	attr_accessor :delete_diagram, :delete_photo
	before_validation { diagram.clear if delete_diagram == '1' }
	before_validation { photo.clear if delete_photo == '1' }

end