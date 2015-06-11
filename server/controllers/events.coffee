'use strict'

Resource  = require '../models/events'
express   = require 'express'

router = express.Router()

router.get '/', (req, res) ->
  query = req.query
  if query.hasOwnProperty '_id'
    Resource.findById query._id, (err, resource) ->
      if err 
        res.send err
      res.json [resource]
  else
    Resource.find {query},(err, resources) ->
      if err 
        res.send err
      res.json resources

router.post '/', (req, res) ->
  Resource.create req.body, (err, resource) ->
    if err
      res.send err
    res.json resource

router.put '/:_id', (req, res) ->
  Resource.findByIdAndUpdate req.params._id, req.body, (err, resource) ->
    if err
      res.send err
    res.json resource

router.delete '/:_id', (req, res) ->
  Resource.findByIdAndRemove req.params._id, req.body, (err, resource) ->
    if err
      res.send err
    res.json resource


i = 0
n = 2
while i < n
  Resource.remove {}, ->
    Resource.create {
      name: 'Kinski - Früher habe ich alle Menschen gehasst!'
      image: '/uploads/images/actors/klaus_kinski.png'
      date:  new Date
      location: 'hell'
      description: 'Schlechtes Benehmen halten die Leute 
                    doch nur deswegen für eine Art Vorrecht, 
                    weil keiner ihnen aufs Maul haut.'
    }, ->
  i++

module.exports = router