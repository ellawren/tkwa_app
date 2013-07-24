class AddViewOptionsToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :view_options, :string, default: ['name', 'work', 'personal'], array: true
  end
end
