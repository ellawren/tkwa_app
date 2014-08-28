class CreateRecreateConsultants < ActiveRecord::Migration
  def change
    create_table :consultants do |t|
    	t.string :name
      	t.timestamps
    end
  end
end
