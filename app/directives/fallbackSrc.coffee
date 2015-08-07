fallbackSrc = ->
  (scope, element, attrs) ->
    element.bind 'error', ->
      angular.element(this).attr 'src', attrs.fallbackSrc

module.exports = fallbackSrc
