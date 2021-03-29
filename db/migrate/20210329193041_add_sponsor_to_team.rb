class AddSponsorToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :sponsor, :string
  end
end
