class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name

      t.timestamps
    end
    add_column :schedules, :tour_id, :integer
  end
end
