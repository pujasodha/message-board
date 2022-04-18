class CommentsController < ApplicationController
  before_action :set_post, :set_comment

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    response_for(@comment, 'created')
  end

  def destroy
    @comment.destroy

    redirect_to post_url(@post)
  end

  def update
    response_for(@comment, 'updated')
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
      method_succesful = action == 'created' ? comment.save : comment.update(comment_params)

      if method_succesful
        format.html { redirect_to post_url(@post), notice: "Comment #{action}" }
      else
        format.html { redirect_to post_url(@post), alert: "Comment was not #{action}" }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
