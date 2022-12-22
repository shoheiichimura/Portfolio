class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

   def create
     @post = Post.find(params[:post_id])
     @comment = Comment.new(comment_params)
     @comment.customer_id = current_customer.id
     @comment.post_id = @post.id
     if @comment.save
     @post.create_notification_comment!(current_customer, @comment.id)
     else
      render 'public/posts/show'
     end
   end

   def destroy
     @post = Post.find(params[:post_id])
     Comment.find(params[:id]).destroy
   end

   private

   def comment_params
     params.require(:comment).permit(:comment)
   end
   
end
