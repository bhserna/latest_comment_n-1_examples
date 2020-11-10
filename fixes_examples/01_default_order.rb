require_relative "config"

class Post < ActiveRecord::Base
  has_many :comments
  has_many :sorted_comments, -> { order(:id) }, class_name: "Comment"

  def latest_comment
    sorted_comments.last
  end
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

Seeds.run(posts_count: 10, comments_count: 10)

Post.includes(:sorted_comments).all.each do |post|
  puts post.latest_comment.body
end
