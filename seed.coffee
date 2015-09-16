fs = require('fs')
mongoose = require('mongoose')
ActorModel = require('./server/models/actors')
EventModel = require('./server/models/events')

mongoose.connect 'mongodb://localhost/ernst-busch-actors', (err) ->
  if err
    console.log err
    console.log 'Is mongodb running?'

fs.readFile 'text-katalogwebsite.txt', 'utf8', (err, data) ->
  if err
    return console.log err

  actorsArray = parseActors data

  ActorModel.remove {}, (err) ->
    if err
      console.log err
    console.log 'clean up finished'

    ActorModel.create actorsArray, (err) ->
      seedEvents(exit)

exit = ->
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
    nameString = sectionStringArray[0].split('\n').filter(Boolean)[0]
    actor.firstName         = nameString.slice 0, nameString.lastIndexOf(' ')
    actor.lastName          = nameString.slice nameString.lastIndexOf(' ') + 1
    actor.birthdate         = sectionStringArray[0].match(/Geboren am (.*)/)[1]
    actor.height            = sectionStringArray[0].match(/Körpergröße (.*)/)[1]
    actor.hairColor         = sectionStringArray[0].match(/Haarfarbe (.*)/)[1]
    actor.eyeColor          = sectionStringArray[0].match(/Augenfarbe (.*)/)[1]
    actor.foreignLanguages  = sectionStringArray[0].match(/Sprachen ((.|\n)*)/)[1].split(/\n(Besondere|Dialekte)/)[0].replace(/\n/g, '')

    actor.images = []
    imageUrl = '/uploads/images/actors/'
    actorNameUrl = nameString.toLowerCase().replace(/\ /g, '_').
      replace('ä','ae').replace('ü','ue').replace('ö','oe').replace('ë','ee')

    actor.thumbnail         = imageUrl + 'thumbnails/' + actorNameUrl + '.jpg'

    image1 = url: imageUrl + actorNameUrl + '_1.jpg'
    image2 = url: imageUrl + actorNameUrl + '_2.jpg'
    image3 = url: imageUrl + actorNameUrl + '_3.jpg'
    actor.images.push image1
    actor.images.push image2
    actor.images.push image3

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
          tabSplit = roleString.replace(/\n/g, '').split('\t').filter(Boolean)
          role.year   = tabSplit[0]
          role.title  = tabSplit[1]
          role.info   = tabSplit[2]
          actor.roles.push role

      #
      # Engagements
      #
      if sectionStringArray[l].match(/Engagements((.|\n)*)/)
        engagementsStringArray = sectionStringArray[l].match(/Engagements((.|\n)*)/)[1].replace(/20/g, '+-20').split('+-').splice(1)

        for engagementString in engagementsStringArray
          engagement = {}
          tabSplit = engagementString.replace(/\n/g, '').split('\t').filter(Boolean)
          engagement.year   = tabSplit[0]
          engagement.title  = tabSplit[1]
          engagement.info   = tabSplit[2]

          actor.engagements.push engagement

      #
      # Movies
      #
      if sectionStringArray[l].match(/Film\/TV((.|\n)*)/)
        moviesStringArray = sectionStringArray[l].match(/Film\/TV((.|\n)*)/)[1].replace(/20/g, '+-20').split('+-').splice(1)

        for movieString in moviesStringArray
          movie = {}
          tabSplit = movieString.replace(/\n/g, '').split('\t').filter(Boolean)
          movie.year   = tabSplit[0]
          movie.title  = tabSplit[1]
          movie.info   = tabSplit[2]
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

seedEvents = (callback) ->
  console.log 'seed events'
  actorsArray = [
    {name: 'Annemarie Brüntjen'}
    {name: 'Lukas Darnstädt'}
    {name: 'Florian Donath'}
    {name: 'Stella Hinrichs'}
    {name: 'Jonathan Kutzner'}
    {name: 'Seraina Leuenberger'}
    {name: 'Janine Meißner'}
    {name: 'Jaëla Carlina Probst'}
    {name: 'Llewellyn Reichman'}
    {name: 'Linn Reusse'}
    {name: 'Tim Riedel'}
    {name: 'Leonard Scheicher'}
    {name: 'Gregor Schleuning'}
    {name: 'Gregor Schulz'}
    {name: 'Felix Strobel'}
    {name: 'Karoline Teska'}
    {name: 'Gaia Vogel'}
    {name: 'Gregor Schleuning'}
    {name: 'Fabian Wehmeier'}
    {name: 'Sebastian Witt'}
    {name: 'Timocin Ziegler'}
  ]

  EventModel.remove {}, ->
    EventModel.create [
      {
        name: 'Generalprobe Intendantenvorspiel Tag 1'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("October 19, 2015 10:00")
        actors: actorsArray
      }
      {
        name: 'Generalprobe Intendantenvorspiel Tag 2'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("October 20, 2015 10:00")
        actors: actorsArray
      }
      {
        name: 'Intendantenvorspiel Tag 1'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("October 21, 2015 10:00")
        actors: actorsArray
      }
      {
        name: 'Intendantenvorspiel Tag 2'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("October 22, 2015 10:00")
        actors: actorsArray
      }
      {
        name: 'Zentrales Vorsprechen München'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("November 10, 2015 10:00")
        actors: actorsArray
      }
      {
        name: 'Beschreibung eines Kampfes'
        description: 'nach Franz Kafka, Grüner Salon der Volksbühne Berlin. R.: Lukas Darnstädt & Nikolas Darnstädt'
        image: '/uploads/images/events/kampf.jpeg'
        date_start:  new Date("December 17, 2015")
        link: 'http://www.volksbuehne-berlin.de/deutsch/spielplan/'
        actors: [
          {name: 'Lukas Darnstädt'}
        ]
      }
      {
        name: 'Schlafe mein Prinzchen'
        description: 'R.: Franz Wittenbrink, Berliner Ensemble'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("September 6, 2015")
        link: 'http://www.berliner-ensemble.de/repertoire/titel/114/schlafe-mein-prinzchen'
        dates: [new Date("September 6, 2015"), new Date("October 13, 2015")]
        actors: [
          {name: 'Annemarie Brüntjen'}
        ]
      }
      {
        name: 'Deutschstunde'
        description: 'Berliner Ensemble, R.: Philip Tiedemann'
        image: '/uploads/images/events/default.jpg'
        date_start:  new Date("September 1, 2015")
        link: 'http://www.berliner-ensemble.de/repertoire/titel/113/deutschstunde'
        dates: [new Date("September 1, 2015"),new Date("September 2, 2015"),new Date("September 8, 2015"),
          new Date("September 13, 2015"), new Date("October 9, 2015"), new Date("October 30, 2015")]
        actors: [
          {name: 'Felix Strobel'}
        ]
      }
      {
        name: 'Was ihr Wollt'
        description: 'R.: Alexander Lang, bat in der Parkstraße 16, 13086 Berlin-Weißensee'
        image: '/uploads/images/events/wollt.jpeg'
        date_start:  new Date("September 22, 2015")
        link: 'http://www.bat-berlin.de/'
        dates: [new Date("September 22, 2015"), new Date("October 22, 2015")]
        actors: [
          {name: 'Stella Hinrichs'}
          {name: 'Jaela Carlina Probst'}
          {name: 'Llewellyn Reichman'}
          {name: 'Linn Reusse'}
          {name: 'Gaia Vogel'}
          {name: 'Florian Donath'}
          {name: 'Tim Riedel'}
          {name: 'Jonathan Kutzner'}
          {name: 'Leonard Scheicher'}
          {name: 'Gregor Schulz'}
          {name: 'Sebastian Witt'}
        ]
      }
      {
        name: 'Fabian - Der Gang vor die Hunde'
        description: 'R.: Peter Kleinert Schaubühne am Lehniner Platz'
        image: '/uploads/images/events/fabian.jpg'
        date_start:  new Date("September 24, 2015")
        link: 'https://www.schaubuehne.de/de/produktionen/fabian-der-gang-vor-die-hunde.html/m=318'
        dates: [new Date("September 6, 2015"),new Date("September 6, 2015"),new Date("September 6, 2015"),
          new Date("September 24, 2015"),new Date("September 25, 2015"),new Date("October 2, 2015"),
          new Date("October 3, 2015"),new Date("October 4, 2015"), new Date("October 21, 2015"),
          new Date("October 24, 2015"),new Date("October 25, 2015"), new Date("November 3, 2015"),
          new Date("November 4, 2015"),new Date("November 29, 2015"), new Date("November 30, 2015")]
        actors: [
          {name: 'Florian Donath'}
          {name: 'Stella Hinrichs'}
          {name: 'Janine Meißner'}
          {name: 'Llewellyn Reichmann'}
          {name: 'Tim Riedel'}
          {name: 'Timocin Ziegler'}
          {name: 'Gregor Schulz'}
        ]
      }
      {
        name: 'Zwei Herren aus Verona'
        description: 'R.: Veit Schubert, Berliner Ensemble'
        image: '/uploads/images/events/herren.jpeg'
        date_start:  new Date("October 12, 2015")
        link: 'http://www.berliner-ensemble.de/repertoire/titel/108/zwei-herren-aus-verona'
        dates: [new Date("October 12, 2015"), new Date("October 14, 2015"),
          new Date("October 21, 2015"),new Date("October 29, 2015")]
        actors: [
          {name: 'Annemarie Brüntjen'}
          {name: 'Karoline Teska'}
          {name: 'Gaia Vogel'}
          {name: 'Jonathan Kutzner'}
          {name: 'Leonard Scheicher'}
          {name: 'Felix Strobel'}
          {name: 'Sebastian Witt'}
        ]
      }
      {
        name: 'Monster'
        description: 'R.: Veit Schubert, Berliner Ensemble'
        image: '/uploads/images/events/monster.jpeg'
        date_start:  new Date("October 2, 2015")
        link: 'R.: Simon Solberg, Deutsches Theater Berlin'
        dates: [new Date("October 2, 2015"), new Date("October 20, 2015")]
        actors: [
          {name: 'Linn Reusse'}
          {name: 'Gregor Schleuning'}
        ]
      }], ->
        callback()
