
class Tagging < ApplicationRecord
    validates :tag_topic, :shortened_url, presence: true
    validates :shortened_url_id, uniqueness: { scope: :tag_topic_id }
end