class RemoveCompanies < ActiveRecord::Migration
  def up
  	drop_table :companies
  end

  def down
  	create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax
      t.string :url

      t.timestamps
    end
  end
end
