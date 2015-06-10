'use strict'

server = require './server'

port = process.env.PORT or 3000
server.start port

# dummy export for brunch
exports.startServer = (port, path, callback) ->
	callback()

