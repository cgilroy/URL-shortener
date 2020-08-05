class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, :submitter_id, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming, :nonpremium_max

    belongs_to :submitter,
        class_name: :User, 
        primary_key: :id,
        foreign_key: :submitter_id
    
    has_many :visits,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit

    has_many :visitors, -> { distinct },through: :visits, source: :visitor

    has_many :taggings,
        class_name: :Tagging,
        primary_key: :id,
        foreign_key: :shortened_url_id
    
    has_many :tag_topics, through: :taggings, source: :tag_topic

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

    def no_spamming
        recent_posts = ShortenedUrl.where("created_at > ?", 1.minute.ago)
        .where(submitter_id: submitter_id).count

        errors.add(:max, "number of urls is 5 per minute") if recent_posts >= 5
    end

    def nonpremium_max
        total_urls = ShortenedUrl.where(submitter_id: submitter_id).count

        errors.add(:member, "must be premium to make more than 5 short urls") if total_urls >= 5
    end
end