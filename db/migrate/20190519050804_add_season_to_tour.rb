class AddSeasonToTour < ActiveRecord::Migration[5.2]
  def change
  	add_column :tours , :season_id, :integer
  end
end
