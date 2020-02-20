module CommentsHelper

  def authorize_admin_or_owner_for_comment
    @comment = Comment.find(params[:id])
    redirect_to root_path unless is_admin? || current_user == @comment.user
  end

end
