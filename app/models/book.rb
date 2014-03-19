class Book < ActiveRecord::Base
  	belongs_to :subject
end
# == Schema Information
#
# Table name: books
#
#  id             :integer         not null, primary key
#  title          :string(255)
#  author         :string(255)
#  index          :integer
#  shelf_location :string(255)
#  type           :string(255)
#  loc_data       :text
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  description    :text
#  subject_id     :integer
#

