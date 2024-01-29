# frozen_string_literal: true

# LINE通知設定
class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)
    @notification_setting.user = current_user

    if @notification_setting.save
      redirect_to root_path, notice: '通知設定が保存されました'
    else
      render :new
    end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end
