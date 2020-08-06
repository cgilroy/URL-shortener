
class TagTopic < ApplicationRecord
    validates :name, presence:true

    has_many :taggings,
        class_name: :Tagging,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        dependent: :destroy

    has_many :shortened_urls,
        through: :taggings,
        source: :shortened_url

    def popular_links
        links = shortened_urls.sort_by { |url_obj| url_obj.num_clicks }.reverse
        links.map { |url_obj| url_obj.long_url + ': ' + url_obj.num_clicks.to_s }.take(5)
    end

end