class AddMeetingToScheduleItems < ActiveRecord::Migration
  def change
  	add_column :schedule_items, :meeting, :string, default: "task"
  end
end
