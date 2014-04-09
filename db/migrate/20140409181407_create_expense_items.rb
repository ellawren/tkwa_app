class CreateExpenseItems < ActiveRecord::Migration
  def change
    create_table :expense_items do |t|
      t.integer :expense_report_id
      t.integer :project_id
      t.string :date
      t.string :description
      t.integer :miles
      t.decimal :food, :precision => 6, :scale => 2
      t.decimal :parking, :precision => 6, :scale => 2
      t.decimal :misc, :precision => 6, :scale => 2

      t.timestamps
    end
  end
end