class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :compare_current_user_blog_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all
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
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = current_user.blogs.build(blogs_params)
    if  params[:cache][:image].present?
      @blog.image.retrieve_from_cache! params[:cache][:image]
    end
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
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
    @blog = current_user.blogs.build(blogs_params)
    render :new if @blog.invalid?
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  def top5
    @blogs = Blog.top5
    respond_to do |format|
      format.html
      format.json { render json: @blogs }
    end
  end

  # Season = params[:season]

  # case season

  # when 1 then
  #   Blog.where(blogs.season:1)
  # when 2 then
  #   Blog.where()
  # when 3 then
  #   Blog.where()
  # when 4 then
  #   Blog.where()
  # else
  #   redirect_to new_user_session_path, notice: "ログイン画面に戻りました！"
  # end


  private
  def blogs_params
    params.require(:blog).permit(:title, :content, :image)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def compare_current_user_blog_user
    unless current_user == user.id
      redirect_to blogs_path
    end
  end
end
