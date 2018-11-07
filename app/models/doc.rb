class Doc < ApplicationRecord
    rails_admin do 
  
        def initialize(params = {})
            file = params.delete(:file)
            super
            if file
                self.filename = File.basename(file.original_filename)
                self.content_type = file.content_type
                self.file_contents = file.read
            end
        end
        
    end
end
