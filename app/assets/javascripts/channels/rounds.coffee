$(document).on 'turbolinks:load', ->
  round = $("#secret")
  if $('#secret').length > 0
    App.rounds = App.cable.subscriptions.create {
      channel: "RoundsChannel"
      round_id: round.data('round-id')
    },
      connected: ->
        console.log("connected")

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log("Reached")
        console.log(data)
        # Called when there's incoming data on the websocket for this channel
        if data.name
          $("#users-ul").append("<li>" + data.name + "</li>")
        if data.restaurants
          $('body').empty()
          for i in data.restaurants
            $('#container').append('<p>' + i.name + '</p>')

