class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new()
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      flash[:notice] = t (".success")
      redirect_to admin_announcements_path
    else
      @announcements = Announcement.all
      render :index, status: :unprocessable_entity
    end
  end
  

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body, :start_at, :end_at)
  end
end
