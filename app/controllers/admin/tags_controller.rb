class Admin::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_tag, only: [ :edit, :update, :destroy ]

  def index
    @tag = Tag.new()
    if params[:q].present?
      @tags = Tag.where("name LIKE ?", "%#{Tag.sanitize_sql_like(params[:q])}%")
    else
      @tags = Tag.all
    end
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

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @tag.destroy
      respond_to do |format|
        format.html { redirect_to admin_tags_path, notice: "Tag was successfully destroyed." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_tags_path, alert: "Something went wrong." }
        format.turbo_stream
      end
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
