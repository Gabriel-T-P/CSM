class ContentsController < ApplicationController
  def new
    @content = Content.new
    @user = User.find(params[:user_id])
    @tags = Tag.all
  end
end