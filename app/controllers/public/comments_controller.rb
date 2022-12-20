class Public::CommentsController < ApplicationController
  before_action :ensure_guest_user, only: [:create]

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
     Comment.find(params[:id]).destroy
     redirect_to post_path(params[:post_id])
   end

   private

   def comment_params
     params.require(:comment).permit(:comment)
   end
   
   def ensure_guest_user
     if current_customer.name == "guestuser"
       redirect_to request.referer , alart: 'ゲストユーザーはコメントできません。'
     end
   end
end
