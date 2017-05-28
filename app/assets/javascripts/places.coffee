ready = ->

  enter_function = ->
    id = $(@).data 'place-id'
    lat = $(@).data 'place-lat'
    lng = $(@).data 'place-lng'
    gmaps.selectMarker(id)
    ltlg = new (google.maps.LatLng)(lat,lng)
    gmaps.map.panTo(ltlg)
    gmaps.map.setZoom(13)
    return

  leave_function = ->
    id = $(@).data 'place-id'
    gmaps.deselectMarker(id)
    return

  gmaps = new App.GMaps 'places-map'
  gmaps.render()
  $.get '/places.json', (data) ->
    gmaps.renderItems data
    $('.stans-item').hover enter_function, leave_function
    return

  return

$(document).on 'turbolinks:load', ->
  return unless $('.places.index').length > 0
  ready()