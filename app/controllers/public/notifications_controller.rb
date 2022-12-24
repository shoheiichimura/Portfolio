class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_customer.passive_notifications.page(params[:page]).per(8).order('created_at DESC').where(checked: false)
  end

  def update
    notification = Notification.find(params[:id])
    notification.update(checked: true)
    redirect_to notifications_path
  end

end

