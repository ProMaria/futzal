class Schedule < ApplicationRecord
    belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"

    belongs_to :guest_team, :class_name => "Team", :foreign_key => "guest_team_id"
    
    belongs_to :tour
    
    scope :finished, ->{where("result!=''").order(timestamp: :desc)}
   
end
