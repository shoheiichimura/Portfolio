class Admin::PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(15).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer.id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました！"
      redirect_to admin_posts_path
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.destroy
      flash[:notice] = "投稿削除完了しました！"
      redirect_to admin_posts_path
     else
      redirect_to request.referer
     end
  end

  private

  def post_params
    params.require(:post).permit(:title,:caption,:image)
  end
end
