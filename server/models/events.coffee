'use strict'

mongoose    = require 'mongoose'

eventSchema = new mongoose.Schema
  name:     
    type: String
    required: true
  image: String
  date: Date
  location: String
  description: String



Event = mongoose.model 'Event', eventSchema

module.exports = Event