
class Visit < ApplicationRecord
    validates :visitor, :shortened_url, presence: true

    belongs_to :shortened_url,
        class_name: :ShortenedUrl, 
        primary_key: :id,
        foreign_key: :shortened_url_id
    
    belongs_to :visitor,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    def self.record_visit!(user,shortened_url)
        Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
    end
end