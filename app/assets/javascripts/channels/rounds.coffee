$(document).on 'turbolinks:load', ->
  round = $("#container")
  if $('#container').length > 0
    App.rounds = App.cable.subscriptions.create {
      channel: "RoundsChannel"
      round_id: round.attr('data-round-id')
    },
      connected: ->
        console.log("connected")

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log("Reached")
        $("#container").append("<p>" + data.body + "</p>")
        data = $("#game-key").attr('data-round-id')
        console.log(data)
        # $.ajax
        #   url: '/rounds/' + data + '/group_results' ,
        #   method: 'get',
        #   data: data
        #   success: ->
        # Called when there's incoming data on the websocket for this channel

  $(document).on 'click', '.voteable', ->
    $that = $(this)
    restaurantId = $that.attr('data-restaurant-id')
    roundId = $that.attr('data-round-id')
    $.ajax
      url: '/rounds/' + roundId + '/restaurants/' + restaurantId,
      method: 'put'
      success: ->
        $that.css('background-image': "url(http://indiacompliances.com/wp-content/uploads/2017/02/o.png)").removeClass('voteable')
        $that.find(".restaurant-name").css({'font-size': '40px', 'color': 'white', 'margin-top':'60px'})
        $that.find(".restaurant-price").hide()
        $that.find(".restaurant-rating").hide()


  $(document).on 'submit', '#start-form', (e) ->
    data = {lat: lat, lng: lng}
    console.log(data)
    e.preventDefault()
    $.ajax
      url: '/rounds',
      method: 'post',
      data: data
      success: ->

  $("#round-results").click (e) ->
    e.preventDefault()
    console.log("results clicked")
    roundID = $("#round-results").attr('data-round-id')
    $.ajax
      url: '/rounds/' + roundID + '/results'
      method: 'get'
      success: ->

