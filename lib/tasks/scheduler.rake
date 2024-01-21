namespace :push_line do 
  desc "食事時間計測するリマインドを送信する" 
  task push_line_message_time: :environment do # タスク名の定義（envriment doの後に実行）
      message = {
        type: 'text',
        text: 'もぐもぐタイムの記録の時間です！'
      }
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    User.all.each do |user|
      client.push_message(user.uid, message)
    end
  end

#   task :send_reminders => :environment do
#     User.send_reminders
#   end
# end

# namespace :push_line do  
#   desc "食事時間計測するリマインドを送信する"
#   task push_line_message_time: :environment do # タスク名の定義（envriment doの後に実行）
#     NotificationSetting.where(preferred_time: Time.current.strftime("%H:%M")).find_each do |setting| #現在の時間に合致するpreferred_timeを取得
#       user = User.find(setting.user_id)
#       message = {
#         type: 'text',
#         text: 'もぐもぐタイム記録の時間です！'
#       }
#       client = Line::Bot::Client.new { |config|
#         config.channel_secret = ENV["LINE_SECRET"]
#         config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
#       }
#       response = client.push_message(user.uid, message)
#       Rails.logger.info("Sent notification to #{user.id}: #{response}")
#     end
#   rescue => e
#     Rails.logger.error("Error sending LINE notification: #{e.message}")
#   end
# end