class MapController

  mapStyles: [
      {
        'featureType': 'administrative.province'
        'elementType': 'all'
        'stylers': [ { 'visibility': 'off' } ]
      }
      {
        'featureType': 'administrative.locality'
        'elementType': 'labels.text'
        'stylers': [
          { 'lightness': '-50' }
          { 'visibility': 'simplified' }
        ]
      }
      {
        'featureType': 'landscape'
        'elementType': 'all'
        'stylers': [
          { 'saturation': -100 }
          { 'lightness': 65 }
          { 'visibility': 'on' }
        ]
      }
      {
        'featureType': 'landscape'
        'elementType': 'geometry.fill'
        'stylers': [
          { 'visibility': 'on' }
          { 'saturation': '0' }
          { 'hue': '#ff0000' }
        ]
      }
      {
        'featureType': 'landscape'
        'elementType': 'labels.icon'
        'stylers': [ { 'visibility': 'simplified' } ]
      }
      {
        'featureType': 'poi'
        'elementType': 'all'
        'stylers': [
          { 'saturation': -100 }
          { 'lightness': 51 }
          { 'visibility': 'off' }
        ]
      }
      {
        'featureType': 'poi.government'
        'elementType': 'all'
        'stylers': [ { 'visibility': 'simplified' } ]
      }
      {
        'featureType': 'poi.medical'
        'elementType': 'all'
        'stylers': [ { 'visibility': 'simplified' } ]
      }
      {
        'featureType': 'road'
        'elementType': 'all'
        'stylers': [
          { 'saturation': '-100' }
          { 'lightness': '0' }
        ]
      }
      {
        'featureType': 'road'
        'elementType': 'labels.text'
        'stylers': [ { 'lightness': '0' } ]
      }
      {
        'featureType': 'road'
        'elementType': 'labels.icon'
        'stylers': [ 
          { 'lightness': '50' } 
          { 'visibility': 'off' }          
        ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'all'
        'stylers': [ { 'visibility': 'off' } ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'geometry.fill'
        'stylers': [ { 'color': '#95969a' } ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'labels'
        'stylers': [ { 'lightness': '0' } ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'labels.icon'
        'stylers': [
          { 'visibility': 'off' }
          { 'lightness': '0' }
        ]
      }
      {
        'featureType': 'road.highway.controlled_access'
        'elementType': 'geometry.fill'
        'stylers': [ { 'color': '#3c3c31' } ]
      }
      {
        'featureType': 'road.highway.controlled_access'
        'elementType': 'labels'
        'stylers': [ { 'lightness': '0' } ]
      }
      {
        'featureType': 'road.highway.controlled_access'
        'elementType': 'labels.icon'
        'stylers': [
          { 'lightness': '-10' }
          { 'saturation': '0' }
        ]
      }
      {
        'featureType': 'road.local'
        'elementType': 'all'
        'stylers': [
          { 'visibility': 'on' }
          { 'lightness': '41' }
          { 'saturation': '0' }
        ]
      }
      {
        'featureType': 'transit'
        'elementType': 'all'
        'stylers': [
          { 'saturation': -100 }
          { 'visibility': 'simplified' }
        ]
      }
      {
        'featureType': 'transit.line'
        'elementType': 'geometry.fill'
        'stylers': [ { 'lightness': '0' } ]
      }
      {
        'featureType': 'transit.station.bus'
        'elementType': 'all'
        'stylers': [ { 'visibility': 'off' } ]
      }
      {
        'featureType': 'water'
        'elementType': 'geometry'
        'stylers': [ { 'color': '#dce6e6' } ]
      }
      {
        'featureType': 'water'
        'elementType': 'labels'
        'stylers': [
          { 'visibility': 'on' }
          { 'lightness': -25 }
          { 'saturation': -100 }
        ]
      }
      {
        'featureType': 'water'
        'elementType': 'labels.text'
        'stylers': [ { 'lightness': '50' } ]
      }
    ]

  #
  #
  #
  constructor: (@$scope) ->
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @$scope.map =
      center:
        latitude:   52.4541
        longitude:  13.52014
      zoom: 15
      options:
        panControl:         false
        mapTypeControl:     false
        streetViewControl:  false
        minZoom:            11
        styles:             @mapStyles


MapController.dependencies = [
  '$scope'
]

module.exports = MapController