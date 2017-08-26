class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end
end
