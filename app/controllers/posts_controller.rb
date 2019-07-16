class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index 
    @posts = Post.paginate page: params[:page]
  end

  def show
    @post = Post.find_by id: params[:id]
    redirect_to posts_url unless @post
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new content: params[:content]
    if @post.save 
      flash[:success] = "Post created"
      redirect_to @post 
    else 
      flash.now[:danger] = "Create post fails"
      render 'new'
    end
  end

  def edit 
    @post = Post.find_by id: params[:id]
    redirect_to posts_url unless @post
  end

  def update 
    @post = Post.find_by id: params[:id]
    if @post.update_attributes params.require(:post).permit(:content)
      flash[:success] = "Post updated"
      redirect_to @post 
    else
      flash[:danger] = "Update fails"
      render 'edit'
    end
  end
  
  def destroy 
    @post = Post.find_by params[:id]
    redirect_to posts_url unless @post 
    if @post.destroy 
      redirect_to posts_url
    end
  end

end

