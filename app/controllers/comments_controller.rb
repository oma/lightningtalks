class CommentsController < ApplicationController
  def create
    Rails.logger.debug params
    @comment = Comment.new(params[:comment])
    @comment.talk_id = params[:talk_id]
    @comment.user = @current_user
    @comment.save
    redirect_to @comment.talk
  end
end
