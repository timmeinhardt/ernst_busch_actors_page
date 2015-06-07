'use strict'

path  = require 'path'

actorsController = require './controllers/actors'

setup = (app) ->
  app.get '/', (req, res) -> 
    res.sendFile path.resolve(__dirname + '/../public/index.html')
  app.get '/admin', (req, res) -> 
    res.sendFile path.resolve(__dirname + '/../public/index.html')
  app.use '/actors', actorsController

exports.setup = setup

