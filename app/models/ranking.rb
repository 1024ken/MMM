class Ranking < ApplicationRecord
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

  def self.top3
    ranking = Blog.all.sort_by do |blog|
      blog.rank
    end

    ranking = ranking.keep_if do |blog|
      blog.rank <= 3
    end

    return ranking
  end
end
