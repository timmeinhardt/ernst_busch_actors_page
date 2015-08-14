class HomeController

  #
  #
  #
  constructor: (@$scope, @$window) ->
    @setScrollActivity()

    #@$window.onresize = () =>
    #  @$scope.$apply @setScrollActivity()
    @

  setScrollActivity: () =>
    if @$window.outerHeight < 500
      @$scope.snapScrollActive = false
    else
      @$scope.snapScrollActive = true
    @

HomeController.dependencies = [
  '$scope'
  '$window'
]

module.exports = HomeController