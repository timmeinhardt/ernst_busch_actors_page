'use strict'

pageTitle = "Ernst Busch Absolventen 2016"

#
# Require vendor modules explicitly
#
window._ = require 'lodash'
window.jQuery = window.$ = require 'jquery'
require 'jquery.flexslider'

require 'angular'
require 'angular-route'
require 'angular-google-maps'
require 'angular-resource'
require 'angular-flexslider'
require 'angular-panel-snap.min'

#
# Initialize angularJS app module
#
app = angular.module 'App', [
  'ngRoute'
  'uiGmapgoogle-maps'
  'ngResource'
  'akreitals.panel-snap'
  'angular-flexslider'
]

#
# Register angular components
#
app.controller 'AdminController',  require 'controllers/admin'
app.controller 'MapController',   require 'controllers/map'
app.controller 'HomeController',  require 'controllers/home'

app.directive 'actors', require 'directives/actors'
app.directive 'header', require 'directives/header'
app.directive 'map', require 'directives/map'
app.directive 'footer', require 'directives/footer'
app.directive 'events', require 'directives/events'

app.directive 'backImg', require 'directives/backgroundImg'
app.directive 'fallbackSrc', require 'directives/fallbackSrc'

#
# Setup AngularJS routes
#
app.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider
    .when '/',
      title: pageTitle
      controller: 'HomeController'
      template:   require 'templates'
    .when '/admin',
      title: pageTitle + " Admin"
      controller: 'AdminController'
      template: require 'templates/admin'

#
# Dynamically change browser title for different routes
#
app.run [
  '$location'
  '$rootScope'
  ($location, $rootScope) ->
    $rootScope.$on '$routeChangeSuccess', (event, current, previous) ->
      $rootScope.pageTitle = current.$$route.title
]

#
# Callback for document ready
#
angular.element(document).ready ->
  angular.bootstrap document, ['App']

module.exports = app
