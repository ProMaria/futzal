class AddSeasonToLeague < ActiveRecord::Migration[5.2]
  def change
  	add_column :leagues , :season_id, :integer
  end
end
