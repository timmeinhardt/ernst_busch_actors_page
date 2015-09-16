'use strict'

mongoose    = require 'mongoose'

eventSchema = new mongoose.Schema
  name:
    type: String
    required: true
  image: String
  description: String
  link: String
  date_start: Date
  dates: Array
  actors: [
    {
      name: String
    }
  ]

Event = mongoose.model 'Event', eventSchema

module.exports = Event