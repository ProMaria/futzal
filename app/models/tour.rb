class Tour < ApplicationRecord
    has_many :schedules
    has_many :photos
end
