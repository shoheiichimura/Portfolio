class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_customer.passive_notifications
  end
  
  def update
    notification = Notification.find(params[:id]) 
    if notification.update(checked: true) 
      redirect_to notifications_path
    end
  end
end

# .page(params[:page]).per(20)