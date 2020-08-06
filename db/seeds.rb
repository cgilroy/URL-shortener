# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_1 = User.create!(email: 'connormcdavid@oilers.com', premium:true)
user_2 = User.create!(email: 'jeffbridges@gmail.com')
short_url_1 = ShortenedUrl.create_short_url!(user_1,'www.lolcats.com')
short_url_2 = ShortenedUrl.create_short_url!(user_1,'www.oilers.com')
short_url_3 = ShortenedUrl.create_short_url!(user_2,'www.nhl.com')

Visit.record_visit!(user_1,short_url_1)
Visit.record_visit!(user_1,short_url_2)
Visit.record_visit!(user_1,short_url_2)
Visit.record_visit!(user_2,short_url_3)
Visit.record_visit!(user_2,short_url_3)
Visit.record_visit!(user_2,short_url_3)

tag_topic_1 = TagTopic.create!(name:'Sports')
tag_topic_2 = TagTopic.create!(name: 'Entertainment')

Tagging.create!(shortened_url: short_url_1, tag_topic: tag_topic_2)
Tagging.create!(shortened_url: short_url_2, tag_topic: tag_topic_1)
Tagging.create!(shortened_url: short_url_3, tag_topic: tag_topic_1)