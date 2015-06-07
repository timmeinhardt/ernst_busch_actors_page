header = ->

  restrict: 'E'

  controller: require('controllers/header')

  template: require('templates/header')()

module.exports = header