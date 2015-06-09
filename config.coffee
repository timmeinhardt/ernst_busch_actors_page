exports.config =

  server: 
    path: 'server/index.coffee' 
    port: 3000 
    base: '/' 
    run: yes

  conventions:
    # wrap bower_components into commonjs
    vendor: -> false

	 paths:
    public: 'public'
    watched: [
      'app'
    ]

  files:
    javascripts:
      joinTo:
        'js/app.js':    /^(app|server)/
        'js/vendor.js': /^(bower_components|vendor)/

    stylesheets:
      joinTo: 'css/app.css': /^(app|vendor|bower_components)/
      
    # TODO static index not in template.js
    templates:
      joinTo:
        'js/templates.js': /^.+\.jade$/

  plugins:
    jade:
      options:
        pretty: yes

  minify: true
  sourceMaps: false

  modules:
    nameCleaner: (path) ->
      # make index files available as e.g. require('effects')
      # instead of require('effects/index')
      path = path.replace /\/index\.(js|coffee|jade)$/, ''

      # make app files available as e.g. require('templates/...')
      # instead of require('app/templates/...')
      path = path.replace /^app\//, ''

      # make bower components available as e.g. require('underscore')
      # instead of require('bower_componens/underscore/underscore')
      path = path.replace /^bower_components\/(.*\/)?/, ''

      path