class UsersController < ApplicationController
  def posts
    @user = User.find(params[:id])
    @posts = @user.post.paginate(:per_page => 10, :page => params[:page]).order("created_at DESC")
  end
end
