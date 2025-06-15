class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_announcement, only: [ :edit, :update, :destroy ]

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new()
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      respond_to do |format|
        format.html { redirect_to admin_announcements_path, notice: t(".success") }
        format.turbo_stream
      end
    else
      @announcements = Announcement.all
      flash.now[:alert] = t (".error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      flash[:notice] = t (".success")
      redirect_to admin_announcements_path
    else
      flash[:alert] = t (".error")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @announcement.destroy
      respond_to do |format|
        format.html { redirect_to admin_announcements_path, notice: t(".success") }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_announcements_path, alert: t(".error") }
        format.turbo_stream
      end
    end
  end


  private

  def announcement_params
    params.require(:announcement).permit(:title, :body, :start_at, :end_at)
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end
end
