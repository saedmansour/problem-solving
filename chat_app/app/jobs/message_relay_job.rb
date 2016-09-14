class MessageRelayJob < ApplicationJob
  def perform(message)
    ActionCable.server.broadcast "app_chat:conversation:#{message.conversation.id}",
      message: MessagesController.render(partial: 'messages/message', locals: { message: message })
  end
end
