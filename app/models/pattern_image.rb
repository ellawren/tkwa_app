# == Schema Information
#
# Table name: pattern_images
#
#  id                 :integer         not null, primary key
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  pattern_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class PatternImage < ActiveRecord::Base
	belongs_to :pattern
	has_attached_file :photo, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "200x200>" }
	attr_accessor :delete_photo
    before_validation { photo.clear if delete_photo == '1' }
end

