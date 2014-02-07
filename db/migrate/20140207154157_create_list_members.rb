class CreateListMembers < ActiveRecord::Migration
  def change
    create_table :list_members do |t|
    	t.integer :contact_id
      	t.integer :mailing_list_id

      	t.timestamps
    end
    add_index :list_members, :contact_id
    add_index :list_members, :mailing_list_id
    add_index :list_members, [:contact_id, :mailing_list_id], :unique => true
  end
end
