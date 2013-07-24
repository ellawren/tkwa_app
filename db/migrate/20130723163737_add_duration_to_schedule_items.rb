class AddDurationToScheduleItems < ActiveRecord::Migration
  def change
  	add_column :schedule_items, :duration, :string
  end
end
