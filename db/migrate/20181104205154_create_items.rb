class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.string :body_preview
      t.text :body
      t.integer :count_views, default:0
      
      t.attachment :image

      t.timestamps
    end
  end
end
