class ContentsController < ApplicationController
  def new
    @content = Content.new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end

  def create
    @content = current_user.contents.build(content_params)
    puts params.inspect
    p @content
    if @content.save
      flash[:notice] = "Content upload with success"
      redirect_to user_dashboard_path(current_user)
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end


  private

  def content_params
    params.require(:content).permit(:title, :body, :cover, :visibility, tag_ids: [])
  end
end
