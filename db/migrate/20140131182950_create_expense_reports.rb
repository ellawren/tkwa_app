class CreateExpenseReports < ActiveRecord::Migration
  def change
    create_table :expense_reports do |t|
      t.integer :user_id, :null => false
      t.string :date
      t.integer :project_id
      t.string :description
      t.integer :miles
      t.decimal :food, :precision => 5, :scale => 2
      t.decimal :parking, :precision => 5, :scale => 2
      t.decimal :misc, :precision => 5, :scale => 2
      t.boolean :complete, :default => false

      t.timestamps
    end
  end
end
