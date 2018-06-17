class BlogsController < ApplicationController
  before_action :logged_in?, only: [:new,:show,:edit, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
      if current_user.nil?
        redirect_to new_session_path
      end
  end
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
      @blog.image.retrieve_from_cache!params[:cache][:image]
      @blog.audio.retrieve_from_cache!params[:cache][:audio]
    else
      @blog = Blog.new
    end
  end
  
  def create
      @blog = current_user.blogs.new(blog_params)
      @blog.audio.retrieve_from_cache!params[:cache][:audio]
    if @blog.save
      BlogMailer.blog_mail(@blog).deliver
      redirect_to blog_path(@blog.id), notice: "ブログを作成しました！"
    else
      render "new"
    end
  end
  
  def show
    params[:id]
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path,　notice: "ブログを更新しました！"
    else
      render "edit"
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path,　notice: "ブロクを削除しました！"
  end
  
  def confirm
    @blog = current_user.blogs.new(blog_params)
    render :new if @blog.invalid?
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  private
    def blog_params
      params.require(:blog).permit(:title,:content,:image,:image_cache,:cache,:audio,:audio_cache)
    end

    def set_blog
      @blog=Blog.find(params[:id])
    end
end
