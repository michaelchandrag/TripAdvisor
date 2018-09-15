<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 0%;
        width:0%;
        margin: 0;
        padding: 0;
      }
    </style>
</head>
<body>

<div id="floating-panel">
    </div>
    <div id="map"></div>
    <script>
    
    var globallat;
    var golballng;
      function initMap() {

        var map, infoWindow;
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.397, lng: 150.644},
            zoom: 6
          });
          infoWindow = new google.maps.InfoWindow;
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
              };
			globallat =  position.coords.latitude;
			globallng =  position.coords.longitude;
              infoWindow.setPosition(pos);
              infoWindow.setContent('Location found.');
              infoWindow.open(map);
              
              map.setCenter(pos);

              geocodeLatLng(geocoder, map, infowindow);
            }, function() {
              handleLocationError(true, infoWindow, map.getCenter());
            });
          }
        else{
        }
        
        var geocoder = new google.maps.Geocoder;
        var infowindow = new google.maps.InfoWindow;
	
        
        document.getElementById('submit').addEventListener('click', function() {
        });
      }

      function geocodeLatLng(geocoder, map, infowindow) {
        var latlng = {lat: parseFloat(globallat), lng: parseFloat(globallng)};
        geocoder.geocode({'location': latlng}, function(results, status) {
          if (status === 'OK') {
            if (results[0]) {
              map.setZoom(11);
              var marker = new google.maps.Marker({
                position: latlng,
                map: map
              });
              infowindow.setContent(results[0].formatted_address);
              infowindow.open(map, marker);

              window.alert(results[0].formatted_address);
            } else {
              window.alert('No results found');
            }
          } else {
            window.alert('Geocoder failed due to: ' + status);
          }
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB8NvYNDtCjxC8Nk3ANItrIQqOhKFUpKSQ&callback=initMap">
    </script>
  </body>
</html>