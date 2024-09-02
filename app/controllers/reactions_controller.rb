class ReactionsController < ApplicationController

  def new_user_reaction
    @user = current_user
    @type = params[:reaction_type]
    @kind = params[:kind]

    # Find post or comment based on the reaction type
    case @type
    when "post"
      @post = Post.find_by(id: params[:post_id])
      @comment = nil
      redirect_path = @post.present? ? post_path(@post) : root_path
    when "comment"
      @comment = Comment.find_by(id: params[:comment_id])
      @post = @comment.present? ? @comment.post : nil
      redirect_path = @post.present? ? post_path(@post) : root_path
    else
      redirect_to root_path, notice: 'Invalid reaction type'
      return
    end

    # Check if the required record was found
    if @post.nil? && @comment.present?
      redirect_to root_path, notice: 'Comment not found'
      return
    elsif @post.nil? && @comment.nil?
      redirect_to root_path, notice: 'Post not found'
      return
    end

    # Find existing reaction
    existing_reaction = if @type == "post"
                          Reaction.find_by(user_id: @user.id, post_id: @post.id)
                        elsif @type == "comment"
                          Reaction.find_by(user_id: @user.id, comment_id: @comment.id)
                        end

    if existing_reaction
      redirect_to redirect_path, notice: 'You already reacted to this'
    else
      @reaction = Reaction.new(user_id: @user.id, reaction_type: @type, kind: @kind)
      @reaction.post_id = @post.id if @post.present?
      @reaction.comment_id = @comment.id if @comment.present?

      if @reaction.save
        redirect_to redirect_path, notice: 'Reaction was successfully created.'
      else
        redirect_to redirect_path, notice: 'Something went wrong'
      end
    end
  end

end
