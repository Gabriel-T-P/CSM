class ContentsController < ApplicationController
  def new
    @content = Content.new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end

  def create
    @content = current_user.contents.build(content_params)
    @content.tag_ids = content_params[:tag_ids]
    if @content.save
      flash[:notice] = t(".success")
      redirect_to user_dashboard_path(current_user)
    else
      flash[:alert] = t(".success")
      render :new, status: :unprocessable_entity
    end
  end


  private

  def content_params
    params.require(:content).permit(:title, :body, :cover, :visibility, tag_ids: [])
  end
end
