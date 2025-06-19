class ContentsController < ApplicationController
  def new
    @content = Content.new
    @user = User.find(params[:user_id])
  end
end