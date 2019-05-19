class Player < ApplicationRecord
    belongs_to :amplua
    belongs_to :team
    default_scope {where(team_id: Team.all.ids)}

    
end
