'use strict'

server = require './server'

exports.startServer = (port, path, callback) ->
	server.start port, callback

