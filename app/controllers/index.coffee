`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  userIsAdmin: Ember.computed.alias 'currentUser.userIsAdmin'
  userIsAdminTester: Ember.computed.alias 'currentUser.userIsAdminTester'
  displayCreateEffort: false
  actions:
    toggleCreateEffort: ->
      @toggleProperty('displayCreateEffort')
      false

`export default IndexController`
