class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.admin = current_admin
    if @comment.save
        flash[:success] = "Comment was successfully created"
        redirect_back(fallback_location: root_path)
      else
        redirect_to root_path
    end
  end

  def destroy
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(
        :content, :report_id
      )
  end

end
