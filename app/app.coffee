'use strict'

pageTitle = "Ernst-Busch Jahrgang 2015"

#
# Require vendor modules explicitly
#
window._ = require('lodash.compat')
require 'angular'
require 'angular-route'
require 'angular-resource'
require 'angular-panel-snap.min'

#
# Initialize angularJS app module
#
app = angular.module 'App', [
  'ngRoute'
  'ngResource'
  'akreitals.panel-snap'
]

#
# Register angular components
#
app.controller 'AdminController',  require 'controllers/admin'
app.controller 'HomeController',  require 'controllers/home'  

app.directive 'actors', require 'directives/actors'
app.directive 'header', require 'directives/header'
app.directive 'footer', require 'directives/footer'
app.directive 'events', require 'directives/events'

app.directive 'backImg', require 'directives/backgroundImg'


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