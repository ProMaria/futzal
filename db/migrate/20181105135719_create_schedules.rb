class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.datetime :timestamp
      t.string :result
      t.integer :home_team_id
      t.integer :guest_team_id

      t.timestamps
    end
  end
end
