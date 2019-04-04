class Tour < ApplicationRecord
    has_many :schedules
    has_many :photos


    def self.current_tours
    	Tour.where("name !~*'финал'")
    end
    def self.final_tours
    	Tour.where("name ~*'финал' and name !~*'полу'").pluck(:id)
    end
    def self.semifinal_tours
    	Tour.where("name ~*'полу'").pluck(:id)
    end
end
