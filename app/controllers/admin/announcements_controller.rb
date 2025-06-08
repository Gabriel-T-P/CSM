class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
  end
end