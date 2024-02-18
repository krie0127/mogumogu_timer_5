# frozen_string_literal: true

class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_notification_setting, only: [:edit, :update, :destroy]
  
  def index
    @notification_settings = current_user.notification_settings.order(:preferred_time)
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
      flash.now[:danger] = @notification_setting.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @notification_setting = NotificationSetting.find(params[:id])
  end

  def update
    if @notification_setting.update(notification_setting_params)
      flash[:notice] = '通知が更新されました'
      redirect_to notification_settings_path
    else
      flash.now[:danger] = '通知設定の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @notification_setting = NotificationSetting.find(params[:id])
    if @notification_setting.destroy
      flash[:alert] = '通知が削除されました'
    else
      flash[:alert] = '通知の削除に失敗しました'
    end
    redirect_to notification_settings_path
  end

  private

  # def find_notification_setting
  #   @notification_setting = NotificationSetting.find(params[:id])
  # end

  def find_notification_setting
    @notification_setting = current_user.notification_settings.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to notification_settings_path, alert: 'Unauthorized access!'
  end
  

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end
