# frozen_string_literal: true

# LINE通知設定
class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!
  
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

  def edit;end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.not_updaed', item: Board.model_name.human)
    else
      flash.now['daner'] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end


  def destroy
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.not_destroy', item: Board.model_name.human)
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end
