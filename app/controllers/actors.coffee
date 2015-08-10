class ActorsController

  #
  #
  #
  constructor: (@$scope, $resource, $document) ->
    @resource = $resource '/actors/:_id', null, 'update': method: 'PUT'
    $document.bind 'keydown', @handleKeyDown
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @resource.query {}, (actors)=>
      @$scope.actors = actors

    @$scope.setTheaterActor       = @setTheaterActor
    @$scope.setTheaterVisibility  = @setTheaterVisibility
    @

  setTheaterActor: (iterator) =>
    # Allow circling through actors
    iterator = 0 if iterator is @$scope.actors.length
    iterator = @$scope.actors.length - 1 if iterator < 0

    actor = @$scope.actors[iterator]

    @$scope.theaterActor          = actor
    @$scope.theaterActor.iterator = iterator
    @

  setTheaterVisibility: (isVisible) =>
    @$scope.$root.bodyClass = if isVisible then 'hideOverflow' else ''
    @$scope.isTheaterVisible = isVisible

  handleKeyDown: (e) =>
    if @$scope.isTheaterVisible
      iterator = @$scope.theaterActor?.iterator

      # right arrow
      if e.keyCode is 39
        iterator++
      # left arrow
      else if e.keyCode is 37
        iterator--
      else
        return

      @$scope.$apply @setTheaterActor(iterator)
    @

ActorsController.dependencies = [
  '$scope'
  '$resource'
  '$document'
]


module.exports = ActorsController