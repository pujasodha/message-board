class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = all_posts&.paginate(page: params[:page], per_page: 10)
  end

  def show
    comments = @post&.comments.includes(:user).order(created_at: :desc)

    @comments = comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    response_for(@post, :new, 'created')
  end

  def edit; end

  def update
    response_for(@post, :edit, 'updated')
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Message successfully destroyed' }
    end
  end

  private

  def all_posts
    @all_posts ||= Post.all.includes(:user).order(created_at: :desc)
  end

  def set_post
    @post = all_posts.find_by(id: params[:id])
  end

  def response_for(post, action, affect)
    respond_to do |format|
      method_succesful = affect == 'created' ? post.save : post.update(post_params)

      if method_succesful
        format.html { redirect_to post_url(post), notice: "Message successfully #{affect}" }
        format.json { render :show, status: :ok, location: post }
      else
        format.html { render action, status: :unprocessable_entity }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :message)
  end
end
