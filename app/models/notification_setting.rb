class NotificationSetting < ApplicationRecord
  belongs_to :user

  validate :custom_preferred_time_validation

  def self.create_or_update_by_user(user, setting_params)
    setting = find_by(user_id: user.id) || new(user_id: user.id)
    setting.assign_attributes(setting_params)
    if setting.save
      true # 保存成功
    else
      setting.errors.full_messages # 保存失敗時のエラーメッセージ配列を返す
    end
  end

  private

  def custom_preferred_time_validation
    if preferred_time.blank?
      errors.add(:base, "時間を指定してください")
    elsif self.class.where(user_id: user_id).where.not(id: id).exists?(preferred_time: preferred_time)
      errors.add(:base, "この時間はすでに設定されています")
    end
  end
end
