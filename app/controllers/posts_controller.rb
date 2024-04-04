# class PostsController < ActionController::Base
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_by] == "asc"
      @posts = Post.all.order("created_at ASC")
    elsif params[:sort_by] == "desc"
      @posts = Post.all.order("created_at DESC")
    else
      @posts = Post.all.order("created_at DESC")
    end
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(params[:post].permit(:title, :content))
    @post = Post.new(post_params)
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
  def show; end

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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end