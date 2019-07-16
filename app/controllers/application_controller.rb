class ApplicationController < ActionController::Base
  def index
    @posts = Post.paginate page: params[:page] 
  end
end
