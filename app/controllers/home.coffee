class HomeController

  #
  #
  #
  constructor: (@$scope, @$window) ->
    #@setScrollActivity()
    #@setWidthViewPortTag()

    @$window.onresize = () =>
      #@setWidthViewPortTag()
      #@$scope.$apply @setScrollActivity()
    @

  setWidthViewPortTag: () =>
    widthViewportTag = @$window.document.getElementById 'width-viewport-tag'

    if @$window.outerWidth < 1200
      widthViewportTag.setAttribute 'content', 'width=1200, initial-scale=1'
    else
      widthViewportTag.setAttribute 'content', 'width=device-width, initial-scale=1'

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