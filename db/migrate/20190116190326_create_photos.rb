class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
		t.attachment :image
        t.references :tour        
    end
  end
end
