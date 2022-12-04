class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to request.referer
    end
  end

  def index
    @posts = Post.limit(10).order('created_at DESC')
    
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
      redirect_to new_post_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title,:caption,:image)
  end
end
