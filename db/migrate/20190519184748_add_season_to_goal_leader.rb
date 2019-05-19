class AddSeasonToGoalLeader < ActiveRecord::Migration[5.2]
  def change
  	add_column :goal_leaders , :season_id, :integer
  end
end
