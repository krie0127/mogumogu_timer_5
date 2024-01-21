# frozen_string_literal: true

# LINE通知設定
class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @preferred_time = Preferred_time.new(notification_setting_params)
    @preferred_time = current_user.id 
    @preferred_time = current_user.uid

    if @preferred_time.save
      redirect_to root_path
    else
      redirect_to new_notification_setting_path
    end

    # saved = NotificationSetting.create_or_update_by_user(current_user, notification_setting_params)

    # if saved
    #   redirect_to root_path, notice: "通知設定が保存されました"
    # else
    #   @notification_setting = current_user.notification_setting || NotificationSetting.new(notification_setting_params)
    #   render :new
    # end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end