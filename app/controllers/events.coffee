class EventsController

  #
  #
  #
  constructor: (@$scope, $resource) ->
    @eventsResource = $resource '/events/:_id', null, 'update': method: 'PUT', isArray: true
    @actorsResource = $resource '/actors/:_id', null, 'update': method: 'PUT', isArray: true
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @$scope.events = @eventsResource.query {}, ()->
    @actorsResource.query {}, (actors)=>
      @actors = actors
      @$scope.actors = @actors

    @$scope.nameFilter = ""
    @$scope.filterEvents = @filterEvents
    @

  filterEvents: (actor) =>
    if @$scope.nameFilter == actor.lastName
      @$scope.nameFilter = ''
    else
      @$scope.nameFilter = actor.lastName
    @

EventsController.dependencies = [
  '$scope'
  '$resource'
]


module.exports = EventsController