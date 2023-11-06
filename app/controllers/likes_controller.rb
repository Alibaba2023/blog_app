class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to user_post_path(current_user, params[:post_id])
  end
end
