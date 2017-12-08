`import Ember from 'ember'`

AdminController = Ember.Controller.extend
  display: "dashboard"
  currentUser: Ember.inject.service()
  userIsAdmin: Ember.computed.alias 'currentUser.userIsAdmin'
  userIsAdminTester: Ember.computed.alias 'currentUser.userIsAdminTester'
  showTable: false
  mappingEffort: Ember.inject.service()
  effort: Ember.computed.alias 'mappingEffort.effort'

  actions:
    toDashboard: ->
      @set 'display', 'dashboard'
    toExportMapping: ->
      @set 'display', 'export-mapping'
    toImportMapping: ->
      @set 'showTable', false
      @set 'display', 'import-mapping'
    toImportTaxonomy: ->
      @set 'showTable', false
      @set 'display', 'import-taxonomy'
    toggleValidations: (bool) ->
      @set('showTable', bool)
      false
    ### TODO : Refactor this at all cost when we add the delta service from Jonathan, this is a workaround as the cache doesn't know we added new stuff without going through it ###
    dataImported: (data) ->
      Ember.$.ajax
        type: "POST"
        url: "/cache/clear"
        data: {}
        success: (data) =>
          console.log "Cache has been cleared"
        error: =>
          console.log "Call to cache/clear failed"
      false
    graphIdReceived: (id) ->
      @set 'graphid', id

`export default AdminController`
