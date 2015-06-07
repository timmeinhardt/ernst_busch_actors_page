'use strict'

mongoose  		= require 'mongoose'
express 			= require 'express'
routes 				= require './routes'
bodyParser 		= require 'body-parser'
errorhandler 	= require 'errorhandler'
morgan        = require 'morgan'

app 			= express()
server 		= require("http").Server(app)

# database
mongoose.connect 'mongodb://localhost/ernst-busch-actors'

# Configuration
app.use bodyParser.json()
app.use express.static(__dirname + '/../public')
app.use '/uploads', express.static(__dirname + '/../uploads')

env = process.env.NODE_ENV || 'development'
if env == 'development'
  app.use errorhandler(dumpExceptions: true, showStack: true)
  app.use morgan('dev')
if env == 'production'
  app.use errorhandler()
  app.use morgan('short')
 
start = (port, callback)->
  routes.setup app
  port = port or process.env.PORT

  server.listen port, callback
  console.log 'Express server listening on port %d in %s mode', port, app.settings.env

exports.start = start
exports.app 	= app
