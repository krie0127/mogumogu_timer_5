# frozen_string_literal: true

# LINE通知設定
class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    debugger
    saved = NotificationSetting.create_or_update_by_user(current_user, notification_setting_params)

    if saved
      redirect_to root_path, notice: "通知設定が保存されました"
    else
      @notification_setting = current_user.notification_setting || NotificationSetting.new(notification_setting_params)
      render :new
    end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end