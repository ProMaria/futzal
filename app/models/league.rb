class League < ApplicationRecord
    has_many :teams, dependent: :destroy
    
    has_many :table_result, dependent: :destroy
    belongs_to :season

    default_scope {joins(:season).where('seasons.current is true')}
end
