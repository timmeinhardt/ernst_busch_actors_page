'use strict'

Resource  = require '../models/actors'
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
n = 12
while i < n
  Resource.remove {}, ->
    Resource.create {
      name: "Lukas Darnstädt"
      image: '/uploads/images/actors/lukas_darnstaedt.png'
      birthdate: new Date "1990-09-22"
      birthplace: "Hamburg"
      height: "182 cm"
      motherLanguage: "Deutsch"
      foreignLanguages: "Französisch, Englisch"
      formalEducation: "Abitur"
      skills: "Ballern"
      
    }, ->
  i++

j = 0
n = 12
while j < n
  Resource.remove {}, ->
    Resource.create {
      name: "Klaus Kinski"
      image: '/uploads/images/actors/klaus_kinski.png'
      birthdate: new Date "1926-09-22"
      birthplace: "Hölle"
      height: "182 cm"
      motherLanguage: "Deutsch"
      foreignLanguages: "Französisch, Englisch"
      formalEducation: "Abitur"
      skills: "Ballern, Ausrasten, Beschimpfen, Hassen, Fechten, Tanzen, Kickboxen, Ballett, Schwimmen, Briefmarken sammeln, Jesus mit der Peitsche in die Fresse schlagen"
    }, ->
  j++

module.exports = router