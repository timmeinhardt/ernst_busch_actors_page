class HeaderController

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
    @$scope.title = "Ernst-Busch"
    
    @

HeaderController.dependencies = [
  '$scope'
]

module.exports = HeaderController