class GoalLeader < ApplicationRecord
    belongs_to :team
    belongs_to :season
    default_scope {where(season_id: Season.ids)}
end
