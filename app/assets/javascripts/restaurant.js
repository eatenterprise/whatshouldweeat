var bindEventHandlers = function(){
  $('#new-restaurant').on('submit', function(event){
    event.preventDefault()
    var $that = $(this)
    var data = $(this).serialize()
    var path = $that.attr('action')
    $.ajax({
      url: path,
      method: 'post',
      data: data
    }).done(function(response){
      $('#name').val('')
      $('#restaurant-list').append('<li>' + response.restaurant.name + '</li>')
    })
  })

  $('#start').on('click', function(event){
    event.preventDefault()
    var path = $(this).attr("href")
    $.ajax({
      url: path
    })
}

$(document).on('turbolinks:load', bindEventHandlers)
//$(document).ready(bindEventHandlers)
