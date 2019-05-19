class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.boolean :current, default: false

      t.timestamps
    end
  end
end
