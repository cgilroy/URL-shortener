
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true

    has_many :submitted_urls,
        class_name: :ShortenedUrl,
        primary_key: :id,
        foreign_key: :submitter_id

end