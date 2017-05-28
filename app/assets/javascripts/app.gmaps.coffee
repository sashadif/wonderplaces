class App.GMaps
  constructor: (@element, @addressInput, @errorsContainer) ->
    @styles = [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f2eddf"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#523735"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#f5f1e6"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#c9b2a6"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#ae9e90"
          }
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f2eddf"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#93817c"
          }
        ]
      },
      {
        "featureType": "poi.attraction",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#e38777"
          }
        ]
      },
      {
        "featureType": "poi.attraction",
        "elementType": "labels.icon",
        "stylers": [
          {
            "color": "#d8563f"
          }
        ]
      },
      {
        "featureType": "poi.attraction",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d74e35"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#c4caa4"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#447530"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f5f1e6"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#fdfcf8"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f8c967"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#e9bc62"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e98d58"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#db8555"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#806b63"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#8f7d77"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#ebe3cd"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#b9d3c2"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#92998d"
          }
        ]
      }
    ];

    @iconBase = {
      path: 'M0-48c-9.8 0-17.7 7.8-17.7 17.4 0 15.5 17.7 30.6 17.7 30.6s17.7-15.4 17.7-30.6c0-9.6-7.9-17.4-17.7-17.4z'
      fillColor: '#bfa8d7',
      size: new google.maps.Size(48, 48)
      fillOpacity: 0.95,
      scale: 1,
      strokeColor: '#8c62b7',
      strokeWeight: 7
    };

    @markers = []

  render: ->
    return unless document.getElementById(@element)
    # center of the universe
    latlng = new (google.maps.LatLng)(50.450028, 30.524088)
    options =
      zoom: 11
      center: latlng
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
      gestureHandling: 'cooperative'
      styles: @styles
    # create our map object
    @map = new (google.maps.Map)(document.getElementById(@element), options)
    # the geocoder object allows us to do latlng lookup based on address
    @geocoder = new (google.maps.Geocoder)
    # event triggered when map is clicked
#    @errorsContainer.hide()
    return

  # fill in the UI elements with new position data
  update_ui: (address) ->
    @addressInput.autocomplete 'close'
    @addressInput.val address
    return

  # Query the Google geocode object
  #
  # type: 'address' for search by address
  #       'latLng'  for search by latLng (reverse lookup)
  #
  # value: search query
  #
  # update: should we update the map (center map and position marker)?
  geocode_lookup: (type, value, update) ->
  # default value: update = false
    update = if typeof update != 'undefined' then update else false
    request = {}
    request[type] = value
    @geocoder.geocode request, (results, status) ->
      @errorsContainer.html ''
      @errorsContainer.hide()
      if status == google.maps.GeocoderStatus.OK
        # Google geocoding has succeeded!
        if results[0]
          # Always update the UI elements with new location data
          update_ui results[0].formatted_address
          # Only update the map (position marker and center map) if requested
          if update
            update_map results[0].geometry
        else
          # Geocoder status ok but no results!?
          @errorsContainer.html 'Sorry, something went wrong. Try again!'
          @errorsContainer.show()
      else
        # Address not recognised (e.g. search for 'zxxzcxczxcx')
        @errorsContainer.html 'Sorry! We couldn\'t find ' + value + '. Try a different search term, or click the map.'
        @errorsContainer.show()
      return
    return

  # initialise the jqueryUI autocomplete element
  autocomplete_init: ->
    @addressInput.autocomplete
      source: (request, response) ->
        # the geocode method takes an address or LatLng to search for
        # and a callback function which should process the results into
        # a format accepted by jqueryUI autocomplete
        @geocoder.geocode { 'address': request.term }, (results, status) ->
          response $.map(results, (item) ->
            {
              label: item.formatted_address
              value: item.formatted_address
              geocode: item
            }
          )
          return
        return
      select: (event, ui) ->
        update_ui ui.item.value
        update_map ui.item.geocode.geometry
        return
    # triggered when user presses a key in the address box
    @addressInput.bind 'keydown', (event) ->
      if event.keyCode == 13
        geocode_lookup 'address', @addressInput.val(), true
        # ensures dropdown disappears when enter is pressed
        @addressInput.autocomplete 'disable'
      else
        # re-enable if previously disabled above
        @addressInput.autocomplete 'enable'
      return
    return

  createMarker: (place) ->
    marker =
      position:
        lat: parseFloat(place.lat)
        lng: parseFloat(place.lng)
      title: place.name
      id: place.id
      map: @map
      icon: @iconBase
    @markers.push new (google.maps.Marker)(marker)

  findMarker: (id) ->
    i = 0
    len = @markers.length
    while i < len
      if @markers[i].id == id
        return @markers[i]
      i++
    null

  animateMarker: (id, animation) ->
    marker = @findMarker id
    marker.setAnimation animation
    return

  selectMarker: (id) ->
    @animateMarker id, google.maps.Animation.BOUNCE
    return

  deselectMarker: (id) ->
    @animateMarker id, null
    return

  renderItems: (data) ->
    $.each data, (index, item) =>
      @createMarker item
      return
    return
