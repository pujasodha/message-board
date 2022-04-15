class CommentsController < ApplicationController
  before_action :set_post, :set_comment

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment has been created'
    else
      redirect_to post_path(@post), alert: 'Comment has not been created'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def update
    response_for(@comment, 'update')
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
  end

  def response_for(comment, action)
    respond_to do |format|
      if comment.update(comment_params)
        format.html { redirect_to post_url(@post), notice: "Comment #{action}" }
      else
        format.html { redirect_to post_url(@post), alert: "Comment was not  #{action}" }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
