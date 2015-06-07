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
    @$scope.title = "Ernst Busch Jahrgang 2015"
    
    @

HeaderController.dependencies = [
  '$scope'
]

module.exports = HeaderController