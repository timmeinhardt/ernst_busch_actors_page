fs = require('fs')
mongoose = require('mongoose')
ActorModel = require('./server/models/actors')
imageUrl = '/uploads/images/actors/'

mongoose.connect 'mongodb://localhost/ernst-busch-actors'

fs.readFile 'text-katalogwebsite.txt', 'utf8', (err, data) ->
  if err
    return console.log err

  actorsArray = parseActors data

  ActorModel.remove {}, (err) ->
    if err
      console.log err
    console.log 'clean up finished'

    ActorModel.create actorsArray, (err) ->
      console.log 'seed finished'

      mongoose.connection.close()
      process.exit()


parseActors = (data) ->
  actorStringsArray = data.split('\n\n\n')

  actors = []

  for actorString in actorStringsArray
    actor = {}

    # Split actor in sections and delete empty string elements
    sectionStringArray = actorString.split('\n\n').filter(Boolean)

    #
    # Profile attributes array
    #
    actor.name              = sectionStringArray[0].split('\n').filter(Boolean)[0]
    actor.thumbnail         = imageUrl + 'thumbnails/' + actor.name.toLowerCase().replace(' ', '_') + '.png'
    actor.birthdate         = sectionStringArray[0].match(/Geboren am (.*)/)[1]
    actor.height            = sectionStringArray[0].match(/Körpergröße (.*)/)[1]
    actor.hairColor         = sectionStringArray[0].match(/Haarfarbe (.*)/)[1]
    actor.eyeColor          = sectionStringArray[0].match(/Augenfarbe (.*)/)[1]
    actor.foreignLanguages  = sectionStringArray[0].match(/Sprachen (.*)/)[1]

    actor.images = []
    image1 = url: imageUrl + actor.name.toLowerCase().replace(' ', '_') + '_1.png'
    actor.images.push image1

    actor.birthplace = null
    if sectionStringArray[0].match(/Aufgewachsen in (.*)/)
      actor.birthplace = sectionStringArray[0].match(/Aufgewachsen in (.*)/)[1]
    actor.nationality = null
    if sectionStringArray[0].match(/Nationalität (.*)/)
      actor.nationality = sectionStringArray[0].match(/Nationalität (.*)/)[1]
    actor.physique = null
    if sectionStringArray[0].match(/Statur (.*)/)
      actor.physique = sectionStringArray[0].match(/Statur (.*)/)[1]
    actor.dialects = null
    if sectionStringArray[0].match(/Dialekte (.*)/)
      actor.dialects = sectionStringArray[0].match(/Dialekte (.*)/)[1]
    actor.agency = null
    if sectionStringArray[0].match(/Agentur (.*)/)
      actor.agency = sectionStringArray[0].match(/Agentur (.*)/)[1]
    actor.otherSkills = sectionStringArray[0].match(/Besondere Fähigkeiten ((.|\n)*)/)[1].split('\nAgentur')[0].replace(/\n/g, '')

    actor.roles = []
    actor.engagements = []
    actor.movies = []

    l = 1
    while l < sectionStringArray.length
      #
      # Roles
      #
      if sectionStringArray[l].match(/Gearbeitete Rollen\/Dozent((.|\n)*)/)
        rolesStringArray = sectionStringArray[l].match(/Gearbeitete Rollen\/Dozent((.|\n)*)/)[1].replace(/20/g, '+-20').split('+-').splice(1)

        for roleString in rolesStringArray
          role = {}
          role.year   = roleString.replace(/\n/g, '').split('\t')[0]
          role.title  = roleString.replace(/\n/g, '').split('\t')[1]
          role.info   = roleString.replace(/\n/g, '').split('\t')[2]
          actor.roles.push role

      #
      # Engagements
      #
      if sectionStringArray[l].match(/Engagements((.|\n)*)/)
        engagementsStringArray = sectionStringArray[l].match(/Engagements((.|\n)*)/)[1].replace(/20/g, '+-20').split('+-').splice(1)

        for engagementString in engagementsStringArray
          engagement = {}
          engagement.year   = engagementString.replace(/\n/g, '').split('\t')[0]
          engagement.title  = engagementString.replace(/\n/g, '').split('\t')[1]
          engagement.info   = engagementString.replace(/\n/g, '').split('\t')[2]
          actor.engagements.push engagement

      #
      # Movies
      #
      if sectionStringArray[l].match(/Film\/TV((.|\n)*)/)
        moviesStringArray = sectionStringArray[l].match(/Film\/TV((.|\n)*)/)[1].replace(/20/g, '+-20').split('+-').splice(1)

        for movieString in moviesStringArray
          movie = {}
          movie.year   = movieString.replace(/\n/g, '').split('\t')[0]
          movie.title  = movieString.replace(/\n/g, '').split('\t')[1]
          movie.info   = movieString.replace(/\n/g, '').split('\t')[2]
          actor.movies.push movie

      #
      # Others
      #
      if sectionStringArray[l].match(/Sonstiges((.|\n)*)/)
        othersString = sectionStringArray[l].match(/Sonstiges((.|\n)*)/)[1].replace('\n', '')
        actor.others = othersString

      l++

    actors.push actor

  actors
