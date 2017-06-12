$(document).on 'turbolinks:load', ->
  round = $("#container")
  if $('#container').length > 0
    App.rounds = App.cable.subscriptions.create {
      channel: "RoundsChannel"
      round_id: round.attr('data-round-id')
    },
      connected: ->

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $("body").empty()
        $("body").append(data.body)

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
    e.preventDefault()
    radius = $(this).find('select option:selected').text()
    switch radius
      when '1/2 Mile' then radius = 800
      when '2 Miles' then radius = 3200;
      when '5 Miles' then radius = 6400;
      when '10 Miles' then radius = 16000;
      else radius = 3200
    data = {lat: lat, lng: lng, radius: radius}
    $.ajax
      url: '/rounds',
      method: 'post',
      data: data
      success: ->

  $("#results-link").click (e) ->
    console.log('link clicked')
    e.preventDefault()
    roundID = $("#round-results-btn").attr('data-round-id')
    $.ajax
      url: '/rounds/' + roundID + '/results'
      method: 'get'
      success: ->

