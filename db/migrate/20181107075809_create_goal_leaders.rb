class CreateGoalLeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :goal_leaders do |t|
        t.references :team
        t.string :fio
        t.integer :goal

      
    end
  end
end
