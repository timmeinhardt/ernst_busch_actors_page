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



Resource.remove {}, ->
  Resource.create {
    name: 'Generalprobe Intendantenvorspiel Tag 1'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("October 19, 2015 10:00")
  }, ->
  Resource.create {
    name: 'Generalprobe Intendantenvorspiel Tag 2'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("October 20, 2015 10:00")
  }, ->
  Resource.create {
    name: 'Intendantenvorspiel Tag 1'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("October 21, 2015 10:00")
  }, ->
  Resource.create {
    name: 'Intendantenvorspiel Tag 2'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("October 22, 2015 10:00")
  }, ->
  Resource.create {
    name: 'Zentrales Vorsprechen München'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("November 10, 2015 10:00")
    date_end:  new Date("November 10, 2015 12:40")
  }, ->
  Resource.create {
    name: 'Beschreibung eines Kampfes'
    description: 'nach Franz Kafka, Grüner Salon der Volksbühne Berlin. R.: Lukas Darnstädt & Nikolas Darnstädt'
    image: '/uploads/images/events/event_default.jpg'
    date_start:  new Date("December 17")
    link: 'http://www.volksbuehne-berlin.de/deutsch/spielplan/'
    actors: ['Lukas Darnstädt']
  }, ->

module.exports = router