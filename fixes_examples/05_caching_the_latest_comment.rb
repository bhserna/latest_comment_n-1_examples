require_relative "config"

class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :cached_comment, class_name: "Comment"
end

class Comment < ActiveRecord::Base
  belongs_to :post
  after_commit :update_cached_comment

  private

  def update_cached_comment
    post.update(cached_comment_id: id)
  end
end

Seeds.run

Post.includes(:cached_comment).all.each do |post|
  puts post.cached_comment.body
end
