class Team < ApplicationRecord
    belongs_to :league
    #has_many :teams
    has_many :goal_leaders, dependent: :destroy
    has_many :players, dependent: :destroy
    has_many :table_result, dependent: :destroy
    #has_many :home_teams, :class_name => "Team", :foreign_key => "home_team_id"
    #has_many :guest_teams, :class_name => "Team", :foreign_key => "guest_team_id"
    
    def schedules
        Schedule.where('home_team_id=? or guest_team_id=?', self.id, self.id)
    end
    
    has_attached_file :image, {:styles => { :small => "150x150>" },
            
    url: "/system/:hash.:extension",
    hash_secret: "dc6360523aa19bd9913d64b7ebc83009c09ab5e48814f713c3027e92bf457b0d70f5f3f8d8ec1adc6450664198dc0090ece075c54eb852def1147e972f9ed64d",
    convert_options: {
                      thumb: "-quality 70 -strip",
                      original: "-quality 90"
                  }
    }
    
    validates_attachment :image,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 1.megabyte }
    
    def count_games
        at_home_schedule = Schedule.finished.where(home_team_id: self.id)
        at_guest_schedule = Schedule.finished.where(guest_team_id: self.id)
        counter_all=counter_win = counter_lost=counter_pat = counter_ball_create=counter_ball_lost= 0
				counter_all=at_home_schedule.count+at_guest_schedule.count				
        at_home_schedule.each do |s|					
					home_goal = s.result.split(':')[0]
					guest_goal = s.result.split(':')[1]
					counter_ball_create = counter_ball_create+home_goal.to_i
					counter_ball_lost = counter_ball_lost+guest_goal.to_i
					home_goal.to_i>guest_goal.to_i ? counter_win+=1 : home_goal.to_i<guest_goal.to_i ? counter_lost+=1 : counter_pat+=1
				end
				
				at_guest_schedule.each do |s|					
					home_goal = s.result.split(':')[0]
					guest_goal = s.result.split(':')[1]
					counter_ball_create = counter_ball_create+guest_goal.to_i
					counter_ball_lost = counter_ball_lost+home_goal.to_i
					
					home_goal.to_i<guest_goal.to_i ? counter_win+=1 : home_goal.to_i>guest_goal.to_i ? counter_lost+=1 : counter_pat+=1
				end
				return counter_all, counter_win, counter_pat, counter_lost,counter_ball_create,counter_ball_lost
				
    end
		
		

   
end
