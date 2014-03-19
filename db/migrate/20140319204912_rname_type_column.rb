class RnameTypeColumn < ActiveRecord::Migration
  def change
  	rename_column :books, :type, :material_type
  end
end
