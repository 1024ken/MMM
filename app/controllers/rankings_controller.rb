class RankingsController < ApplicationController

  def index
    @rankings = Ranking.all
  end

  def ranking
    like_ids = Blog.group(:like_id).order('count_like_id DESC').limit(3).count(:like_id).keys
    @rankings = like_ids.map {|id| like.find(id)}
  end

  private
  def rankings_params
    params.require(:blog).permit(:title, :content)
  end
end
