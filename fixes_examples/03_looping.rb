require_relative "config"

class Post < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post

  def self.latest_comments_for_posts
    where(id: select("max(id)").group(:post_id))
  end
end

class Feed
  def posts
    posts = Post.all
    comments = Comment.latest_comments_for_posts.group_by(&:post_id)
    posts.map { |post| FeedPost.new(post, comments[post.id]&.first) }
  end
end

class FeedPost
  attr_reader :latest_comment

  def initialize(post, latest_comment)
    @post = post
    @latest_comment = latest_comment
  end
end

Seeds.run(posts_count: 10, comments_count: 10)

Feed.new.posts.map do |post|
  puts post.latest_comment.body
end
