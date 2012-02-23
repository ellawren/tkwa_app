class CreateReimbursables < ActiveRecord::Migration
  def change
    create_table :reimbursables do |t|
      t.string :reimbursable_name

      t.timestamps
    end
  end
end
