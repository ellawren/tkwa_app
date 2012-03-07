class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :number
      t.string :description

      t.timestamps
    end
  end
end
