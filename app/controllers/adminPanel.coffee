class AdminPanelController

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
    resources = @resource.query {}, =>
      @$scope.resources    
    @$scope.saveResource   = @saveResource
    @$scope.removeResource = @removeResource
    @$scope.editResource   = @editResource
    @
  
  # TODO: correct error handling
  saveResource: =>
    resource = @$scope.formResource
    if resource._id
      @resource.update _id: resource._id, resource
    else
      resource = new @resource(resource)

      resource.$save =>
        @$scope.resources.push resource
        @$scope.formResource = {}

  # TODO: correct error handling
  removeResource: (resource) =>
    remove = @resource.remove _id: resource._id
    remove.$promise.then (resource) =>
      @dropResource resource

  editResource: (resource) =>
    @$scope.formResource = resource

AdminPanelController.dependencies = [
  '$scope'
  '$resource'
]

module.exports = AdminPanelController