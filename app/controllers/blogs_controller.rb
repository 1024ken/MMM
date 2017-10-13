class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :compare_current_user_blog_user, only: [:edit, :update, :destroy]

  def index
    @season = params[:season].to_i
    @blogs = Blog.search(@season)
    return redirect_to root_path unless @blogs
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
  end

  def new
    @season = params[:format].to_i
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @season = params[:blog][:season].to_i
    @blog = current_user.blogs.build(blogs_params)
    if  params[:cache][:image].present?
      @blog.image.retrieve_from_cache! params[:cache][:image]
    end
    if @blog.save
      session[:season] = @blog.season
      redirect_to blogs_path(season: @season), notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render 'edit'
    end
  end

  def confirm
    @season = params[:blog][:season].to_i
    @blog = current_user.blogs.build(blogs_params)
    render :new if @blog.invalid?
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    @_current_user = session[:season] = nil
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  def top5
    @blogs = Blog.top5
    respond_to do |format|
      format.html
      format.json { render json: @blogs }
    end
  end

  private
  def blogs_params
    # convert_season_str(params[:blog][:season])
    season = convert_season_str(params[:blog][:season])
    params[:blog][:season] = season
    params.require(:blog).permit(:title, :content, :image, :season)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def convert_season_str(id)
    season = id.to_i
    case season
    when 1 then
      "spring"
    when 2 then
      "summer"
    when 3 then
      "autumn"
    when 4 then
      "winter"
    else
      false
    end
  end


  # def compare_current_user_blog_user
  #   unless current_user == user.id
  #     redirect_to blogs_path
  #   end
  # end
end
