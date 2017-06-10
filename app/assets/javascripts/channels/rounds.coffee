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

  $(document).on 'click', '.voteable', ->
    $that = $(this)
    restaurantId = $that.attr('data-restaurant-id')
    roundId = $that.attr('data-round-id')
    $.ajax
      url: '/rounds/' + roundId + '/restaurants/' + restaurantId,
      method: 'put'
      success: ->
        $('.voted-restaurants').append($that)
        $('.voted-restaurants').find('.restaurant-item').show()
        $that.hide('voteable')
        $that.css('color': 'red').append("<p class='center'>You Voted</p>")

  $('#start-form').on 'submit', (e) ->
    data = {lat: lat, lng: lng}
    console.log(data)
    e.preventDefault()
    $.ajax
      url: '/rounds',
      method: 'post',
      data: data
      success: ->

