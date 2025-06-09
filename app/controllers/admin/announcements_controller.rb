class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new()
  end
end
