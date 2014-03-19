class Book < ActiveRecord::Base
  	belongs_to :subject

  	# next/prev
    scope :next, lambda {|id| where("id > ?",id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

    def next
        Book.next(self.id).first
    end

    def previous
        Book.previous(self.id).first
    end
end
# == Schema Information
#
# Table name: books
#
#  id             :integer         not null, primary key
#  title          :text
#  author         :string(255)
#  index          :integer
#  shelf_location :string(255)
#  material_type  :string(255)     default("Book")
#  loc_data       :text
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  description    :string(255)
#  subject_id     :integer
#  date           :string(255)
#  categories     :text
#  status         :string(255)     default("On Shelves")
#  borrower       :string(255)
#

