class PostsController < ApplicationController
  #Главная страница index
  def index
    @posts = Post.search(params[:search]).paginate(:per_page => 10, :page => params[:page]).order("created_at DESC")
  end
  # Новый пост
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  # Редактирование поста
  def edit
    get_params_id
    if !user_signed_in? #ЕСЛИ ВОЙДЕН ТО FALSE ЕСЛИ НЕТ ТО TRUE
      redirect_to posts_path
    elsif @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
    else
      redirect_to posts_path
    end
  end

  def update
    get_params_id
    if !user_signed_in? #ЕСЛИ ВОЙДЕН ТО FALSE ЕСЛИ НЕТ ТО TRUE
      redirect_to posts_path
    elsif @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
      @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  # Удаление поста
  def destroy
    get_params_id
    if !user_signed_in? #ЕСЛИ ВОЙДЕН ТО FALSE ЕСЛИ НЕТ ТО TRUE
      redirect_to posts_path
    elsif @post.user_id == current_user.id #СРАВНЕНИЕ ЕГО ЛИ ПОСТ
      @post.destroy
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  # Просмотр поста
  def show
    get_params_id
  end

  private
  #ПОЛУЧЕНИЕ ПОСТА ИЗ :id
  def get_params_id
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
