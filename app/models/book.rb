class Book < ActiveRecord::Base
    
  	belongs_to :subject

    has_attached_file :photo, :styles => { :medium => "200x300>", :thumb => "100x150>"}, :default_url => "book_avatar_:style.png"
    attr_accessor :delete_photo
    before_validation { photo.clear if delete_photo == '1' }

    has_many :recommendations, :dependent => :destroy
    has_many :users, :through => :recommendations
    accepts_nested_attributes_for :recommendations, :allow_destroy => true, :reject_if => lambda { |a| a[:description].blank? }

end
# == Schema Information
#
# Table name: books
#
#  id                 :integer         not null, primary key
#  title              :text
#  author             :string(255)
#  index              :integer
#  shelf_location     :string(255)
#  material_type      :string(255)     default("Book")
#  loc_data           :text
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  description        :string(255)
#  subject_id         :integer
#  date               :string(255)
#  categories         :text
#  status             :string(255)     default("On Shelves")
#  borrower           :string(255)
#  date_checked_out   :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

