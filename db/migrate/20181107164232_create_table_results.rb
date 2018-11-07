class CreateTableResults < ActiveRecord::Migration[5.2]
  def change
    create_table :table_results do |t|
      t.references :league
      t.references :team
      t.integer :count_game
      t.integer :count_win
      t.integer :count_pat
      t.integer :count_lost
      t.integer :count_ball_create
      t.integer :count_ball_lost
      t.integer :sub_ball
      t.integer :score
      t.integer :place

     
    end
  end
end
