# class PostsController < ActionController::Base
# require 'kaminari'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :unpublish]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_post_owner, only: [:edit, :update, :destroy, :unpublish]

  def index
    @posts = Post.includes(:categories, :user).where(status: 'published')

    if params[:category].present?
      category_names = params[:category]
      @posts = @posts.joins(:categories).where(categories: { name: category_names })
    end

    if params[:username].present?
      @posts = @posts.joins(:user).where("users.username LIKE ?", "%#{params[:username]}%")
    end

    @posts = @posts.order(created_at: params[:sort_by] == "asc" ? :asc : :desc)
    @posts = @posts.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(params[:post].permit(:title, :content))
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  # def show
  #   @post = Post.find(params[:id])
  # end
  #
  def show
    @comments = @post.comments.page(params[:page]).per(5)
    @comment = Comment.new
  end

  # def edit
  #   @post = Post.find(params[:id])
  # end
  def edit; end

  def update
    # @post = Post.find(params[:id])
    # if @post.update(params.require(:post).permit(:title, :content))
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end


  def unpublish
    @post.update(status: 'unpublished')
    flash[:notice] = 'Post was successfully unpublished'
    redirect_to posts_path
  end


  def api_news
    api_key = ENV['API_KEY']
    url = 'https://newsapi.org/v2/top-headlines'
    params = { 'apiKey': api_key, country: 'ph' }
    response = RestClient.get url, params: params
    response.body

    render json: response.body
    # response_body = JSON.parse(response)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, category_ids: [])
  end

  def validate_post_owner
    unless @post.user == current_user || current_user.role == 'admin'
      flash[:notice] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end
end