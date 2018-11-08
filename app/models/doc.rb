class Doc < ApplicationRecord
    validate :file_size_under_one_mb

    
end
