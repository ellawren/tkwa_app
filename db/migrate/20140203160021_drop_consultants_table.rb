class DropConsultantsTable < ActiveRecord::Migration
  def up
  	drop_table :consultants
  end

  def down
  	create_table :consultants do |t|
      t.string :company
      t.string :address
      t.string :phone
      t.string :contact
      t.string :contact_email

      t.timestamps
    end
  end
end
