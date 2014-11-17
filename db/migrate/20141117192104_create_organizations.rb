class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :website
      t.string :fax

      t.timestamps
    end
  end
end
