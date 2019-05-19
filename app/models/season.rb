class Season < ApplicationRecord
	has_many :tours
	has_many :goal_leaders
	scope :current, ->{where(current: true)}
	default_scope {order(:id)}
end
