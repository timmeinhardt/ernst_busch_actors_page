plan = require 'flightplan'

# configuration
plan.target 'staging',
  host: '46.101.175.237'
  username: 'deploy'
  agent: process.env.SSH_AUTH_SOCK

plan.target 'seed',
  host: '46.101.175.237'
  username: 'deploy'
  agent: process.env.SSH_AUTH_SOCK

projectName = 'ernst_busch_actors_page'
tmpDir = projectName + (new Date).getTime()

# run commands on localhost
plan.local (local) ->

  # rsync files to all the target's hosts
  local.log 'Copy files to remote hosts'
  filesToCopy = local.git('ls-files', silent: true).stdout.split('\n')

  if plan.runtime.target == 'seed'
    uploadsToCopy = local.find('uploads', silent:true).stdout.split('\n')
    filesToCopy   = filesToCopy.concat(uploadsToCopy)

  local.transfer filesToCopy, '/tmp/' + tmpDir
  return

# TODO: only deploy if git local is same as remote
# run commands on remote hosts
plan.remote (remote) ->
  remote.log  'Move folder to web root'
  remote.exec 'cp -R /tmp/' + tmpDir + '/. ~/' + projectName
  remote.rm '-rf /tmp/' + tmpDir
  # TODO: make work
  #if plan.runtime.target == 'seed'
  #  remote.log 'Seed database'
  #  remote.exec 'npm run seed'
  remote.log 'Install dependencies'
  # TODO: do not break on first installation
  remote.exec 'npm --production --prefix ~/' + projectName + ' install ~/' + projectName
  remote.log 'Build application'
  # TODO: build in production mode without breaking the JS
  remote.exec '~/' + projectName + '/node_modules/.bin/brunch build ~/' + projectName
  remote.log 'Reload application'
  remote.exec 'export NODE_ENV=production'
  # TODO: do not delete, but reload if already started
  remote.exec 'pm2 delete ' + projectName
  remote.exec 'pm2 start ~/' + projectName + '/server/index.coffee --name ' + projectName