backend = ->

  restrict: 'E'

  controller: require('controllers/adminPanel')

  template: require('templates/adminPanel')()

module.exports = backend