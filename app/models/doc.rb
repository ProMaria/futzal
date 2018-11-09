class Doc < ApplicationRecord
    def uploaded_file=(incoming_file)
        self.filename = incoming_file.original_filename
        self.content_type=incoming_file.content_type
        self.file_contents=incoming_file.read
        
    end
    
    private
    def sanitize_filename(filename)
        return File.basename(filename)
    end

    
end
