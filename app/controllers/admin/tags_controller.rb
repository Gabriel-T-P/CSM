class Admin::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @tag = Tag.new()
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = t(".success")
      redirect_to admin_tags_path
    else
      flash.now[:alert] = t(".error")
      @tags = Tag.all
      render :index
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
