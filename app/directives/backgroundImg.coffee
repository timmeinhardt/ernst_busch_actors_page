backgroundImg = ->
  (scope, element, attrs) ->
    url = attrs.backImg
    element.css
      'background-image': 'url(' + url + ')'

module.exports = backgroundImg
