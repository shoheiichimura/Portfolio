class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿完了しました！"
      redirect_to request.referer
    end
  end

  def index
    @posts = Post.limit(10).order('created_at DESC')
    
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      flash[:notice] = "更新しました！"
      redirect_to new_post_path
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
     if @post.destroy
      flash[:notice] = "削除完了しました！"
      redirect_to new_post_path
     end
  end

  private
  def post_params
    params.require(:post).permit(:title,:caption,:image)
  end
end
