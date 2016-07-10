require 'angular-mocks'

module.exports =
  injectServices: (services...) ->
    obj = {}
    beforeEach ->
      inject ($injector) ->
        obj[s] =  $injector.get(s) for s in services
        return
      return
    return obj


  getCompiledElement: (html) ->
    E = {}
    beforeEach inject ($rootScope, $compile) ->
      E.scope = $rootScope.$new()
      element = angular.element html
      E.template = $compile(element)(E.scope)
      E.scope.$digest()
      return
    return E
