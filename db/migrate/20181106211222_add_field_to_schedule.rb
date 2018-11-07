class AddFieldToSchedule < ActiveRecord::Migration[5.2]
  def change
      add_column :schedules, :summary, :text
  end
end
