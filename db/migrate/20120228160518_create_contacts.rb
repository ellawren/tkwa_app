class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name

      t.string :work_title
      t.string :work_company
      t.string :work_department

      t.string :work_address
      t.string :work_phone
      t.string :work_ext
      t.string :work_assistant
      t.string :work_direct
      t.string :work_fax
      t.string :work_email
      t.string :work_url

      t.string :home_address
      t.string :home_phone
      t.string :home_cell
      t.string :home_email

      t.string :staff_contact

      t.text :notes

      t.boolean :employee, :default => false

      t.string :category

      t.timestamps
    end
  end
end
