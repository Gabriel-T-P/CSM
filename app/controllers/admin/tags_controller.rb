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
      @tags = Tag.all
      @success_message = t(".success")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_tags_path, notice: t(".success") }
      end
    else
      @tags = Tag.all
      respond_to do |format|
        format.html do
          flash.now[:alert] = t(".error")
          render :index, status: :unprocessable_entity
        end
      end
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
