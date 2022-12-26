class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
    @posts = current_customer.posts.page(params[:page]).per(8).order('created_at DESC')
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿完了しました！"
      redirect_to post_path(@post.id)
    else
      @posts = Post.page(params[:page]).per(8).order('created_at DESC')
      render "new"
    end
  end

  def index
    @q = Post.page(params[:page]).per(16).order('created_at DESC').ransack(params[:q])
    @posts = @q.result(distinct: true)
    @count = @posts.total_count

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
      flash[:notice] = "投稿を更新しました！"
      redirect_to new_post_path
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.destroy
      flash[:notice] = "投稿削除完了しました！"
      redirect_to new_post_path
     else
      redirect_to request.referer
     end
  end

  private
  def post_params
    params.require(:post).permit(:title,:caption,:image)
  end

end
