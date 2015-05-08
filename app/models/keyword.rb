# == Schema Information
#
# Table name: keywords
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  key_category_id    :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Keyword < ActiveRecord::Base

	has_and_belongs_to_many :patterns
	belongs_to :key_category

	has_attached_file :image, :styles => { :large => "300x300#", :medium => "210x210#", :thumb => "80x80#"}, :default_url => "image_:style.png"
    attr_accessor :delete_image
    before_validation { image.clear if delete_image == '1' }

end
