class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, :submitter_id, presence: true
    validates :short_url, uniqueness: true

    belongs_to :submitter,
        class_name: :User, 
        primary_key: :id,
        foreign_key: :submitter_id

    def self.random_code
        loop do
            url = SecureRandom.urlsafe_base64(16)
            return url unless ShortenedUrl.exists?(short_url: url)
        end    
    end

    def self.create_short_url!(user,input_url)
        ShortenedUrl.create!(
            short_url: ShortenedUrl.random_code,
            long_url: input_url,
            submitter_id: user.id
        )
    end
end