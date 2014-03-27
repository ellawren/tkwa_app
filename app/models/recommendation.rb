# == Schema Information
#
# Table name: recommendations
#
#  id          :integer         not null, primary key
#  book_id     :integer
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

class Recommendation < ActiveRecord::Base

  	belongs_to :book
  	belongs_to :user

end


