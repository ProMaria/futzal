class AddFieldToDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :docs, :schedule_id, :integer
  end
end
