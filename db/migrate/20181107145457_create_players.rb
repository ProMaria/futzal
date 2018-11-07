class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :fi
      t.references :amplua
      t.string :year
      t.references :team

    end
  end
end
