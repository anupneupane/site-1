# This is how we require other JS deps!
#= require rails
#= require log_plugin
#= require facebox

@map = undefined

initialize = ->
  latlng =  new google.maps.LatLng(-34.397, 150.644)
  
  myOptions =
    zoom: 16
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  @map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

trygeolocation = ->
  if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((position) ->
        pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        $("#geo_location_message").text("Location successfully found using HTML5.")
        jQuery.facebox(div : '#geo_location_message')
        @map.setCenter pos
      ), ->
        handleNoGeolocation true
    else
      handleNoGeolocation false

handleNoGeolocation = (errorFlag) ->
  if errorFlag
    content = "Error: The Geolocation service failed."
  else
    content = "Error: Your browser doesn't support geolocation."
  $("#geo_location_message").text(content)
  jQuery.facebox(div : '#geo_location_message')
  map.setCenter (new google.maps.LatLng(54.851562,-3.977137))
  map.setZoom(6)

$(document).ready ->
    initialize()
    trygeolocation()
    
    # Facebox
    $.facebox.settings.closeImage = '/assets/facebox/closelabel.png'
    $.facebox.settings.loadingImage = '/assets/facebox/loading.gif'
    $('a[rel*=facebox]').facebox()
