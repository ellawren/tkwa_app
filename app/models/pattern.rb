class Pattern < ActiveRecord::Base
	default_scope order('number ASC')
	belongs_to :project

	  has_attached_file :diagram, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"


end
# == Schema Information
#
# Table name: patterns
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  issue      :text
#  solution   :text
#  author     :string(255)
#  background :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  project_id :integer
#  number     :integer
#  group      :string(255)
#  rating     :integer
#  authors    :string(255)
#  challenges :text
#  approval   :string(255)
#

