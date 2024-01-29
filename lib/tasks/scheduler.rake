namespace :push_line do
  desc '食事時間計測するリマインドを送信する'
  task push_line_message_time: :environment do # タスク名の定義（envriment doの後に実行）
    begin
      jst_time = Time.current
      current_hour = jst_time.hour
      current_minute = jst_time.min

      time_ranges = if current_minute.between?(0, 9)
                      ["#{current_hour}:00:00", "#{current_hour}:09:59"]
                    elsif current_minute.between?(30, 39)
                      ["#{current_hour}:30", "#{current_hour}:39"]
                    end

      # 指定された時間帯に一致する通知設定を検索
      if time_ranges
        NotificationSetting.where(preferred_time: time_ranges[0]..time_ranges[1]).find_each do |setting|
          jst_preferred_time = setting.preferred_time + 9.hours

          user = User.find(setting.user_id)
          message = {
            type: 'text',
            text: 'もぐもぐタイム記録の時間です！'
          }
          client = Line::Bot::Client.new {|config|
            config.channel_secret = ENV['LINE_SECRET']
            config.channel_token = ENV['LINE_CHANNEL_TOKEN']
          }
          response = client.push_message(user.uid, message)
          Rails.logger.info("Sent notification to #{user.id}: #{response}")
        end
      end
    rescue => e
      Rails.logger.error("Error sending LINE notification: #{e.message}")
    end
  end
end
