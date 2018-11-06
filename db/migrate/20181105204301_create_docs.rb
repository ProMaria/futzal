class CreateDocs < ActiveRecord::Migration[5.2]
  def change
    create_table :docs do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents

      t.timestamps
    end
  end
end
