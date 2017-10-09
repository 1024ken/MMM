class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  mount_uploader :image, ImageUploader
  validates :title, :content, presence: true

  def rank
    ranking = Blog.all.collect do |blog|
      blog.likes.count
    end

    self_likes_count = self.likes.count

    high_rank_blogs = ranking.keep_if do |likes_count|
      likes_count > self_likes_count
    end

    return high_rank_blogs.count + 1
  end

  def self.top5
    ranking = Blog.all.sort_by do |blog|
      blog.rank
    end

    ranking = ranking.keep_if do |blog|
      blog.rank <= 5
    end

    return ranking
  end
end
