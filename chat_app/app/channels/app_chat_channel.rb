# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class AppChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "app_chat:conversation:#{data['conversation_id'].to_i}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message
  	#broadcast message all across
  end
end
