class NotificationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_settings do |t|
      t.references :user, foreign_key: true
      t.time :preferred_time

      t.timestamps
    end
  end
end
