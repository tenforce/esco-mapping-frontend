`import Ember from 'ember'`

MappingStatusComponent = Ember.Component.extend
  tagName: "span"
  classNames: ['action']
  classNameBindings: ['disabled','selected', 'mappingActionName']
  currentUser: Ember.inject.service()
  userIsReviewer: Ember.computed.alias 'currentUser.userIsReviewer'
  userIsReviewerTester: Ember.computed.alias 'currentUser.userIsReviewerTester'
  userIsAdmin: Ember.computed.alias 'currentUser.userIsAdmin'
  userIsAdminTester: Ember.computed.alias 'currentUser.userIsAdminTester'
  watcher: Ember.inject.service("mapped-concepts-watcher")
  mappingActionName: Ember.computed.alias 'mappingAction.name'
  disabled: Ember.computed.not 'canChange'
  selected: Ember.computed 'mappingAction.name', 'mapping.status', ->
    @get('mappingAction.name') == @get('mapping.status')
  canChange: Ember.computed 'userIsReviewer', 'userIsReviewerTester', 'userIsAdmin', 'userIsAdminTester', ->
    @get('userIsReviewer') or @get('userIsReviewerTester') or @get('userIsAdmin') or @get('userIsAdminTester')

  actions:
    selectMappingStatus: (mapping, status) ->
      current = mapping.get 'status'
      if not @get('canChange')
        return

      if status == current
        mapping.set 'status', 'todo'
      else if status == 'removed'
        mapping.set 'status', 'removed'
        mapping.set 'matchType', 'no'
      else
        mapping.set 'status', status
      mapping.set('lastModifier', @get('user'))
      mapping.set('lastModified', new Date())

      mapping.save().then(
        =>
          @get('watcher').refresh()
      )


`export default MappingStatusComponent`
