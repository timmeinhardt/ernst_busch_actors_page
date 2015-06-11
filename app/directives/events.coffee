events = ->

  restrict: 'E'

  controller: require('controllers/events')

  template: require('templates/events')()

module.exports = events