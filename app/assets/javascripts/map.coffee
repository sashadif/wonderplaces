initMap = ->
  gmaps = new App.GMaps 'place-map'
  gmaps.render()
  input = document.getElementById('geo-filter-inp')
  options = componentRestrictions: country: 'ua'
  autocomplete = new google.maps.places.Autocomplete(input, options)
  return

google.maps.event.addDomListener document, 'turbolinks:load', initMap
