class CreateContractorRoles < ActiveRecord::Migration
  def change
    create_table :contractor_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
