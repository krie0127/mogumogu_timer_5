# frozen_string_literal: true

# LINE通知設定
class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_notification_setting, only: [:edit, :update, :destroy]
  
  def index
    @notification_settings = NotificationSetting.order(:preferred_time)
  end

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)
    @notification_setting.user = current_user

    if @notification_setting.save
      redirect_to notification_settings_path, notice: '通知設定が保存されました'
    else
      render :new
    end
  end

  def edit
    @notification_setting = NotificationSetting.find(params[:id])
  end

  def update
    if @notification_setting.update(notification_setting_params)
      redirect_to notification_settings_path, success: '通知が更新されました'
    else
      flash.now[:danger] = ”通知設定の更新に失敗しました”
      render:edit
    end
  end

  def destroy
    @notification_setting = NotificationSetting.find(params[:id])
    @notification_setting.destroy
    redirect_to notification_settings_path, notice: '通知が削除されました。'
  end

  private

  def find_notification_setting
    @notification_setting = NotificationSetting.find(params[:id])
  end

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end
