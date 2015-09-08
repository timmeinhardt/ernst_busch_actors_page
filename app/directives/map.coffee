map = ->

  restrict: 'E'

  controller: require('controllers/map')

  template: require('templates/map')()

module.exports = map