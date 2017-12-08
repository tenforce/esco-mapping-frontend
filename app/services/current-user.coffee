`import Ember from 'ember'`

###
# Service keeps track of the current user and the groups where he/she belongs
# and ensures it's data is updated and in sync with the backend.
###
CurrentUserService = Ember.Service.extend
  session: Ember.inject.service('session')
  store: Ember.inject.service('store')
  init: ->
    @_super(arguments...)
    # try get the current account, for if the user is still logged in through cookie
    @ensureUser()
  sessionAuthenticated: ->
    @ensureUser()
  sessionInvalidated: ->
    @set 'user', null

  userInGroup: (groupName) ->
    valid = false
    @get('groups')?.forEach (group) ->
      if group.get('name') is groupName
        valid= true
    return valid

  userIsAdmin: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAPADM')
  userIsAdminTester: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAPADT')
  userIsReviewer: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAPREV')
  userIsReviewerTester: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAPRET')
  userIsMapper: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAP')
  userIsMapperTester: Ember.computed 'user', 'groups', ->
    @userInGroup('EMPL_ESCOMAPT')

  ensureUser: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      accountId = @get('session.data.authenticated.relationships.account.data.id')
      if Ember.isEmpty(accountId)
        reject()
      else
        @get('store').findRecord('account', accountId, include: 'user').then( (account) =>
          account.get('user').then (user) =>
            user.get('groups').then (groups) =>
              @set 'groups', groups
              @set('user', user)
              resolve()
        ).catch(reject)


`export default CurrentUserService`
