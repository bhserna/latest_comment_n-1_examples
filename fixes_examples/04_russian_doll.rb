require_relative "config"

class Post < ActiveRecord::Base
  has_many :comments

  def latest_comment
    comments.order(:id).last
  end
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

def cache(key)
  @store ||= {}
  @store[key] ||= yield
end

def render(posts)
  content =
    posts.map do |post|
      cache(post) do
        post.latest_comment.body
      end
    end
  puts content
end

Seeds.run(posts_count: 10, comments_count: 10)
posts = Post.all

render(posts)
puts "..."
render(posts)
puts "..."
render(posts)
