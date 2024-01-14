namespace :push_line do 
    desc "食事時間計測するリマインドを送信する" 
    task push_line_message_trash: :environment do
        # eat_time = EatTime.new
        message = {
            type: 'text',
            text: 'もぐもぐタイムの記録の時間です！'
        }
        client = Line::Bot::Client.new { |config|
            config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
            config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
        User.all.each do |user|
            client.push_message(user.uid, message)
        end
    end
end