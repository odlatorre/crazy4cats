class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      redirect_to post_path(@post), alert: 'Comment could not be created. Please try again.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
