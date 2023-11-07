class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @comments = @post.comments
  end

  def new; end

  def create
    @current_user = current_user
    @post = @current_user.posts.build(title: params[:title], text: params[:text], author: @current_user,
                                      comments_counter: 0, likes_counter: 0)

    if @post.save
      redirect_to user_posts_path(@current_user) # Redirect to the post show page
    else
      render plain: @post.errors.full_messages
    end
  end
end
