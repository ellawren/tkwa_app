class CreatePotentialProjects < ActiveRecord::Migration
  def change
    create_table :potential_projects do |t|
      t.string :name
      t.string :location
      t.string :client
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email

      t.timestamps
    end
  end
end
