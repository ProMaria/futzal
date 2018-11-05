class CreateReferees < ActiveRecord::Migration[5.2]
  def change
    create_table :referees do |t|
      t.string :fio
      t.string :city
      t.string :category
      t.attachment :image
      t.text :comment
      t.timestamps
    end
  end
end
