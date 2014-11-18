class AddDefunctAndMbeToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :defunct, :boolean, :default => false
  	add_column :consultants, :mbe, :boolean, :default => false
  	add_column :consultant_reviews, :name, :string
  end
end
