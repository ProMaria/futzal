class League < ApplicationRecord
    has_many :teams
    has_many :goal_leaders
end
