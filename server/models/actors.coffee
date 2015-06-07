'use strict'

mongoose    = require 'mongoose'

actorSchema = new mongoose.Schema
  name:     
    type: String
    required: true
  image: String

Actor = mongoose.model 'Actor', actorSchema

module.exports = Actor