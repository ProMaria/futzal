class Amplua < ApplicationRecord
    has_many :players
    validates_presence_of :name
end
