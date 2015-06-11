'use strict'

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
app.controller 'AdminPanelController',  require 'controllers/adminPanel'
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
      controller: 'HomeController'
      template:   require 'templates'
    .when '/admin',
      controller: 'AdminPanelController'
      template: require 'templates/adminPanel'

#
# Callback for document ready
#
angular.element(document).ready ->
  angular.bootstrap document, ['App']

module.exports = app



