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
  motherLanguage: String
  foreignLanguages: String
  formalEducation: String
  skills: String
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