'use strict'

path  = require 'path'

actorsController = require './controllers/actors'
eventsController = require './controllers/events'

setup = (app) ->
  app.get '/', (req, res) -> 
    res.sendFile path.resolve(__dirname + '/../public/index.html')
  app.get '/admin', (req, res) -> 
    res.sendFile path.resolve(__dirname + '/../public/index.html')
  app.use '/actors', actorsController
  app.use '/events', eventsController

exports.setup = setup

