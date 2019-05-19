class TableResult < ApplicationRecord
    belongs_to :league
    belongs_to :team
    # default_scope {where(league_id: League.all.ids)}
    
    

end
