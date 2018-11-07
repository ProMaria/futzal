class League < ApplicationRecord
    has_many :teams, dependent: :destroy
    
    has_many :table_result, dependent: :destroy
end
