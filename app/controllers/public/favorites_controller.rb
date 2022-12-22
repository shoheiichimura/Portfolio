class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(customer_id: current_customer.id)
    favorite.save
    @post.create_notification_favorite!(current_customer)
    # redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to request.referer
  end
  
end
