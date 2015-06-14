class AdminController

  #
  #
  #
  constructor: (@$scope, $resource) ->
    @resource = $resource '/events/:_id', null, 'update': method: 'PUT'
    @initScope()
    @

  #
  #
  #
  initScope: ->
    @$scope.saveResource   = @saveResource
    @$scope.removeResource = @removeResource
    @$scope.editResource   = @editResource

    @resource.query {}, (resources) =>
      @resources        = resources
      @$scope.resources = @resources
    @
  
  # TODO: correct error handling
  saveResource: =>
    resource = @$scope.formResource
    if resource._id
      @resource.update _id: resource._id, resource
    else
      resource = new @resource(resource)

      resource.$save =>
        @resources.push resource
        @$scope.formResource = {}

  # TODO: correct error handling
  removeResource: (resource) =>
    remove = @resource.remove _id: resource._id
    remove.$promise.then (resource) =>
      angular.forEach @resources, (r, i) =>
        if r._id is resource._id
          @resources.splice(i, 1);

  editResource: (resource) =>
    @$scope.formResource = resource

AdminController.dependencies = [
  '$scope'
  '$resource'
]

module.exports = AdminController