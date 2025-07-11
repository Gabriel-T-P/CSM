class ContentsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_user, except: [ :show ]
  before_action :set_content, only: [ :edit, :update, :destroy ]

  def new
    @content = Content.new
    @tags = Tag.all
  end

  def create
    @content = current_user.contents.build(content_params)
    @content.tag_ids = content_params[:tag_ids]
    if @content.save
      flash[:notice] = t(".success")
      redirect_to user_dashboard_path(current_user)
    else
      @tags = Tag.all
      flash[:alert] = t(".error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @content.update(content_params)
      flash[:notice] = t(".success")
      redirect_to @content
    else
      @tags = Tag.all
      flash.now[:alert] = t(".error")
      render :edit, status: :unprocessable_entity
    end
  end

  def index
  end

  def show
    @content = Content.find_by!(code: params[:id])

    return unless @content.only_me?

    if user_signed_in?
      redirect_to user_dashboard_path(current_user), alert: I18n.t("error_messages.route_negated") if @content.user != current_user
    else
      redirect_to new_user_session_path, alert: I18n.t("error_messages.please_login")
    end
  end

  def destroy
    @content.destroy
    flash[:notice] = t(".success")
    redirect_to user_contents_path(@user)
  end


  private

  def content_params
    params.require(:content).permit(:title, :body, :cover, :visibility, tag_ids: [])
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_dashboard_path(current_user), alert: I18n.t("error_messages.route_negated") if @user.id != current_user.id
  end

  def set_content
    @content = Content.find_by!(code: params[:id])
    redirect_to user_dashboard_path(current_user), alert: I18n.t("error_messages.route_negated") if @content.user != current_user
  end
end
