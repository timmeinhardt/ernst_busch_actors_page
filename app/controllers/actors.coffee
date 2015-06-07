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
    actors = @resource.query {}, =>
      @$scope.actors = actors

ActorsController.dependencies = [
  '$scope'
  '$resource'
]


module.exports = ActorsController