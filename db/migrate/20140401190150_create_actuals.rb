class CreateActuals < ActiveRecord::Migration
  def change
    create_table :actuals do |t|
    	t.integer :year
      	t.integer :month
      	t.belongs_to :project_id
      	t.decimal :amount, :precision => 8, :scale => 2

      	t.timestamps
    end
  end
end
