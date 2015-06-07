backgroundImg = ->
  (scope, element, attrs) ->
    url = attrs.backImg
    element.css
      'background-image': 'url(' + url + ')'
      'background-size': 'cover'

module.exports = backgroundImg
