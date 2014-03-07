class CreateNonBillableCategories < ActiveRecord::Migration
  def change
    create_table :non_billable_categories do |t|
      t.string :name
      t.string :shorthand

      t.timestamps
    end
  end
end
