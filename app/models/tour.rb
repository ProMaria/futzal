class Tour < ApplicationRecord
    has_many :schedules
    has_many :photos
    belongs_to :season

    default_scope {joins(:season).where('seasons.current is true')}
   


    def self.current_tours
    	Tour.where("tours.name !~*'финал'")
    end
    def self.final_tours
    	Tour.where("tours.name ~*'финал' and tours.name !~*'1/'").pluck(:id)
    end

    def self.third_tours
        Tour.where("tours.name ~*'3 место'").pluck(:id)
    end

    def self.semifinal_tours
    	Tour.where("tours.name ~*'полу'").pluck(:id)
    end
end
