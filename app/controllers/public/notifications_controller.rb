class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_customer.passive_notifications.where(checked: false)
#    @notifications.where(checked: false).each do |notification|
#      notification.update(checked: true)
#    end
  end

  def update
    notification = Notification.find(params[:id])
    notification.update(checked: true)
    redirect_to notifications_path
  end

end

