class PostsController < ApplicationController
  before_action :get_params_id, only: [:edit, :update, :destroy, :show]
  before_action :get_posts_list, only: [:index, :create, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #Главная страница index
  def index
  end
  # Новый пост
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  # Редактирование поста
  def edit
    if @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
    else
      redirect_to posts_path
      flash[:alert] = "У вас недостаточно прав"
    end
  end

  def update
    if @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
      @post.update_attributes(post_params)
    else
      redirect_to posts_path
      flash[:alert] = "У вас недостаточно прав"
    end
  end

  # Удаление поста
  def destroy
    if @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
      @post.destroy
      redirect_to posts_path
      flash[:notice] = "Успешно удалено."
    else
      redirect_to posts_path
      flash[:alert] = "У вас недостаточно прав"
    end
  end

  # Просмотр поста
  def show
  end

  def myposts
    @posts = Post.where(user_id: current_user.id).paginate(:per_page => 10, :page => params[:page]).order("created_at DESC")
  end

  private
  #ПОЛУЧЕНИЕ ПОСТА ИЗ :id
  def get_params_id
    @post = Post.find(params[:id])
  end

  def get_posts_list
   @posts = Post.search(params[:search]).paginate(:per_page => 10, :page => params[:page]).order("created_at DESC")
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
