class LikesController < ApplicationController
    before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    like = Like.new(user: current_user, post: post)

    unless can?(:like, post)
      flash[:warning] = "That's a bit narcissistic..."
      # We'll return out of this action 
      # so that we don't try to redirect twice
      return redirect_to post_path(post)
    end

    if like.save
      flash[:success] = "Post liked!"
    else
      flash[:danger] = "Already liked"
    end

    redirect_to post_path(post)
  end

  def destroy 
    post = Post.find params[:post_id]
    like = Like.find params[:id]

    if can?(:destroy, like) 
      like.destroy
      flash[:secondary] = "Post unliked"
    else
      flash[:danger] = "Cannot unlike"
    end

    redirect_to post_path(post)
  end
end
