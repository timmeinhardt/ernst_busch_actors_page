'use strict'

mongoose    = require 'mongoose'

actorSchema = new mongoose.Schema
  name:     
    type: String
    required: true
  image: String
  birthdate: Date
  birthplace: String
  height: String
  physique: String
  hairColor: String
  eyeColor: String
  nationality: String
  musicalSkills: String
  foreignLanguages: String
  dialects: String
  danceSkills: String
  otherSkills: String
  appearances: [
    {
      category: String
      year:  String
      role:  String
      title: String
      regisseur: String
    }
  ]



Actor = mongoose.model 'Actor', actorSchema

module.exports = Actor