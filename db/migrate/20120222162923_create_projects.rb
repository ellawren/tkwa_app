class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.decimal :number
      t.string :location
      t.string :client
      
      t.string :building_type
      t.string :client_type
      t.string :status
      
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      
      t.string :billing_name
      t.string :billing_address
      t.string :billing_phone
      t.string :billing_email
      t.string :billing_type
      t.string :billing_travel
      t.string :billing_consultant
      t.string :billing_outofpocket

      t.timestamps
    end
  end
end
