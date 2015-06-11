class EventsController

  #
  #
  #
  constructor: (@$scope, $resource) ->
    @resource = $resource '/events/:_id', null, 'update': method: 'PUT'
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @resource.query {}, (events)=>
      @$scope.events = events

 

EventsController.dependencies = [
  '$scope'
  '$resource'
]


module.exports = EventsController