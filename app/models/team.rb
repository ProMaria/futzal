class Team < ApplicationRecord
    belongs_to :league
    has_many :teams
    has_many :goal_leaders
    
    has_many :home_teams, :class_name => "Team", :foreign_key => "home_team_id"
    has_many :guest_teams, :class_name => "Team", :foreign_key => "guest_team_id"
    
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

   
end
