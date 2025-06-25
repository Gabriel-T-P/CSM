class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

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
      puts params.inspect
      @tags = Tag.all
      flash[:alert] = t(".error")
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end


  private

  def content_params
    params.require(:content).permit(:title, :body, :cover, :visibility, tag_ids: [])
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to root_path, alert: I18n.t("error_messages.route_negated") if @user.id != current_user.id
  end
end
