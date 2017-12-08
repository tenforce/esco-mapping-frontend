`import Ember from 'ember'`

ProfileController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  username: Ember.computed.alias 'user.name'
  isDataValid: Ember.computed 'username', ->
    if @get('username')?.trim()?.length > 0
      return true
    else return false
  toggleBooleanProp: (name) ->
    current = @get name
    if current == "yes"
      @set name, "no"
    else
      @set name, "yes"
  actions:
    saveProfile: ->
      @set('user.name', @get('username'))
      @get('user').save()
    toggleConceptMappings: ->
      @toggleBooleanProp 'user.showMappings'
    toggleConceptDetails: ->
      @toggleBooleanProp 'user.showDetails'
    toggleHierarchyFilters: ->
      @toggleBooleanProp 'user.showFilter'
    toggleCompletedSuggestions: ->
      @toggleBooleanProp 'user.showCompletedSuggestions'

`export default ProfileController`
