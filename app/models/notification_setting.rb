class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :preferred_time, scope: :user_id, message: "同じ時間はすでに設定されています"
  # validates :preferred_time, presence: true, unless: -> { some_condition? }

  def self.create_or_update_by_user(user, setting_params)
    setting = find_by(user_id: user.id) || new(user_id: user.id)
    setting.assign_attributes(setting_params)
    setting.save
  end
end