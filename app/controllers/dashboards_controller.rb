class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end


  private

  def set_user
    @user = User.find(params[:user_id])
    redirect_to root_path, alert: I18n.t("error_messages.route_negated") if @user.id != current_user.id
  end
end
