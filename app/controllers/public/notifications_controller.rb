class Public::NotificationsController < ApplicationController
  
  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_customer.passive_notifications
  end
  
  def update
  notification = Notification.find(params[:id])
  notification.update_attributes(checked: true)
  redirect_to request.referer
  end
end

