class Doc < ApplicationRecord
    validate :file_size_under_one_mb

    def initialize(params={})
    # File is now an instance variable so it can be
    # accessed in the validation.
        puts 'params'
        puts params
    @file = params
    puts 'original filename'
    puts @file(:@original_filename)
    super
    if @file
        self.filename = sanitize_filename(@file.original_filename)
        self.content_type = @file.content_type
        self.file_contents = @file.read
    end
    end

    NUM_BYTES_IN_MEGABYTE = 1048576
    def file_size_under_one_mb
    if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
        errors.add(:file, 'File size cannot be over one megabyte.')
    end
    end
end
