class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = params[:user_id]
    if @post.save
      flash[:notice] = "Your post was saved successfully."
      redirect_to user_post_path(@post.user, @post)
    else
      flash[:alert] = "There was a problem saving your post."
      redirect_to new_user_post_path(@post.user)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Your post was updated successfully."
    else
      flash[:alert] = "There was a problem updating your post."
    end
    redirect_to user_post_path(@post.user, @post)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Your post wasd destroyed successfully"
      redirect_to user_posts_path(@post.user)
    else
      flash[:alert] = "there was a problem."
      redirect_to :back
    end
  end
end