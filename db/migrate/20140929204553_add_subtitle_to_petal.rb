class AddSubtitleToPetal < ActiveRecord::Migration
  def change
  	add_column :petals, :subtitle, :string
  end
end
