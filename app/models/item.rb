class Item < ApplicationRecord
    #has_attached_file :image
    validates :title, presence: true

    validates :body, presence: true    
    
    default_scope {order(created_at: :desc)}
    
    has_attached_file :image, {:styles => { :small => "150x150>" },
            
    url: "/system/:hash.:extension",
    hash_secret: "dc6360523aa19bd9913d64b7ebc83009c09ab5e48814f713c3027e92bf457b0d70f5f3f8d8ec1adc6450664198dc0090ece075c54eb852def1147e972f9ed64d",
    convert_options: {
                      thumb: "-quality 70 -strip",
                      original: "-quality 90"
                  }
    }
    
    validates_attachment :image,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 5.megabyte }

    
end
