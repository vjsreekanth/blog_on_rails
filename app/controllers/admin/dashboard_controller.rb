class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.order(created_at: :desc)
    @posts = Post.order(created_at: :desc)
    @comments = Comment.order(created_at: :desc)
  end
  private

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied!' unless current_user.is_admin
  end
end
