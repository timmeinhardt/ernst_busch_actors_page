'use strict'

mongoose    = require 'mongoose'

actorSchema = new mongoose.Schema
  firstName:
    type: String
    required: true
  lastName:
    type: String
    required: true
  birthdate: String
  birthplace: String
  height: String
  physique: String
  hairColor: String
  eyeColor: String
  nationality: String
  foreignLanguages: String
  dialects: String
  otherSkills: String
  agency: String
  thumbnail: String
  others: String
  images: [
    {
      url: String
    }
  ]
  roles: [
    {
      year:  String
      title:  String
      info: String
    }
  ]
  engagements: [
    {
      year:  String
      title:  String
      info: String
    }
  ]
  movies: [
    {
      year:  String
      title:  String
      info: String
    }
  ]

Actor = mongoose.model 'Actor', actorSchema

module.exports = Actor