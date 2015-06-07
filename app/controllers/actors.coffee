class ActorsController

  #
  #
  #
  constructor: (@$scope, $resource) ->
    @resource = $resource '/actors/:_id', null, 'update': method: 'PUT'
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @resource.query {}, (actors)=>
      @$scope.actors = actors
    @$scope.showActorsTheater = @showActorsTheater

  showActorsTheater: (actor) =>
    @$scope.theaterActor   = actor
    @$scope.theaterVisible = true
    @

ActorsController.dependencies = [
  '$scope'
  '$resource'
]


module.exports = ActorsController