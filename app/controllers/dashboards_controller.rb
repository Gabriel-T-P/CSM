class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @announcements = Announcement.where("start_at IS NULL OR start_at <= ?", Time.current)
                               .where("end_at IS NULL OR end_at >= ?", Time.current)
                               .order(start_at: :desc)
  end


  private

  def set_user
    @user = User.find(params[:user_id])
    redirect_to root_path, alert: I18n.t("error_messages.route_negated") if @user.id != current_user.id
  end
end
