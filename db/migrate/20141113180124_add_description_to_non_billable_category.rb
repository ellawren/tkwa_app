class AddDescriptionToNonBillableCategory < ActiveRecord::Migration
  def change
  	add_column :non_billable_categories, :description, :text
  end
end
