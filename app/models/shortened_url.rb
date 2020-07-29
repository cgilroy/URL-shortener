class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, :submitter_id, presence: true
    validates :short_url, uniqueness: true

    belongs_to :submitter,
        class_name: :User, 
        primary_key: :id,
        foreign_key: :submitter_id
    
    has_many :visits,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit

    has_many :visitors, -> { distinct },through: :visits, source: :visitor

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

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent
        visitors.where("visits.created_at > ?", 10.minutes.ago).count
    end
end