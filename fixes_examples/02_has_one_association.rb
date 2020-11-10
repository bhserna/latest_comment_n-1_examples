require_relative "config"

class Post < ActiveRecord::Base
  has_many :comments
  has_one :latest_comment, -> { Comment.latest_comments_for_posts }, class_name: "Comment"
end

class Comment < ActiveRecord::Base
  belongs_to :post

  def self.latest_comments_for_posts
    where(id: select("max(id)").group(:post_id))
  end
end

Seeds.run(posts_count: 10, comments_count: 10)

Post.includes(:latest_comment).all.each do |post|
  puts post.latest_comment.body
end
