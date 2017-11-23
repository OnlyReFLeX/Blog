class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id #or whatever is you session name
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
