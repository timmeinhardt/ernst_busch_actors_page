plan = require 'flightplan'

# configuration
plan.target 'staging',
  host: '46.101.175.237'
  username: 'deploy'
  agent: process.env.SSH_AUTH_SOCK

plan.target 'production',
  host: '46.101.175.237'
  username: 'deploy'
  agent: process.env.SSH_AUTH_SOCK

projectName = 'ernst_busch_actors_page'
tmpDir = projectName + (new Date).getTime()

# run commands on localhost
plan.local (local) ->
  # confirm deployment to production, as we don't want to do this accidentally
  if plan.runtime.target == 'production'
    input = local.prompt('Ready for deploying to production? [yes]')
    if input.indexOf('yes') == -1
      local.abort 'user canceled flight'
      # this will stop the flightplan right away.

  # rsync files to all the target's hosts
  local.log 'Copy files to remote hosts'
  filesToCopy = local.exec('git ls-files', silent: true)
  local.transfer filesToCopy, '/tmp/' + tmpDir
  return

# run commands on remote hosts
plan.remote (remote) ->
  remote.log  'Move folder to web root'
  remote.exec 'cp -R /tmp/' + tmpDir + '/. ~/' + projectName
  remote.rm '-rf /tmp/' + tmpDir
  remote.log 'Install dependencies'
  #remote.exec 'npm --production --prefix ~/' + projectName + ' install ~/' + projectName
  #remote.log 'Reload application'
  #remote.exec 'pm2 reload ' + projectName

# TODO
# fails first time
# pm2
# missing modules in .bin
#