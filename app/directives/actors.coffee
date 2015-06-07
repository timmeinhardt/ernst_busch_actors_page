actors = ->

  restrict: 'E'

  controller: require('controllers/actors')

  template: require('templates/actors')()

module.exports = actors