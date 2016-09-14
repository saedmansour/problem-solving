App.app_chat = App.cable.subscriptions.create "AppChatChannel",
  collection: -> $("[data-channel='app_chat']")

  connected: ->
    setTimeout =>
      @followChat()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.message) unless @userIsCurrentUser(data.comment)
    alert("data received")

  userIsCurrentUser: (message) ->
    $(message).attr('data-user-id') is $('meta[name=current-user]').attr('id')

  followChat: ->
    alert("follow called")
    if messageId = @collection().data('message-id')
      @perform 'follow', message_id: messageId
    else
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.app_chat.followChat()