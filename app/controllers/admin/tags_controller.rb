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
      flash[:notice] = "Tag created with success"
      redirect_to request.referrer
    else
      flash[:alert] = "Something went wrong"
      redirect_to request.referrer
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
