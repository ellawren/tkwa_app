class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
