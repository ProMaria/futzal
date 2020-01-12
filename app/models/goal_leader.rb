class GoalLeader < ApplicationRecord
    belongs_to :team
    belongs_to :season
    default_scope {where(season_id: Season.ids)}
    validates_uniqueness_of :fio, scope: [:team_id, :season_id]
    validates_presence_of :fio, :team_id, :season_id, :goal
end
