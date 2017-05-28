ready = ->
  
  gmaps = new App.GMaps 'places-map'
  gmaps.render()
  $.get '/places.json', (data) ->
    gmaps.renderItems data
    return
    
  $('#pac-input').autocomplete({
    source: '/places.json'
    select: loadmarker = (e,ui) ->
      $('#pac-input').val(ui.item.value)
      latLng = new (google.maps.LatLng)(ui.item.lat, ui.item.lng)
      gmaps.map.panTo(latLng)
      gmaps.map.setZoom(15)
      return
  });
    
  return
$(document).on 'turbolinks:load', ready