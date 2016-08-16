jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    App.global_chat = App.cable.subscriptions.create {
        channel: "ConversationsChannel"
        conversation_id: messages.data('conversation-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log("received " + data)
        messages.append data['message']
        $("html, body").animate({ scrollTop: $(document).height() }, "slow")

      send_message: (message, conversation_id) ->
        return if $.trim(message).length == 0
        console.log("send message " + message + " to " + conversation_id)
        @perform 'send_message', message: message, conversation_id: conversation_id

      $('#new_message').submit (e) ->
        $this = $(this)
        textarea = $this.find('#message_text')
        message = textarea.val()
        console.log("message " + message)
        App.global_chat.send_message message, messages.data('conversation-id')
        textarea.val('')
        e.preventDefault()
        return false