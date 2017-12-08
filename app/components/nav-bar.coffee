`import Ember from 'ember'`
`import ClickElsewhereMixin from '../mixins/click-elsewhere'`

NavBarComponent = Ember.Component.extend ClickElsewhereMixin,
  session: Ember.inject.service()
  currentUser: Ember.inject.service()
  mappingEffort: Ember.inject.service()
  userIsAdmin: Ember.computed.alias 'currentUser.userIsAdmin'
  userIsAdminTester: Ember.computed.alias 'currentUser.userIsAdminTester'
  concept: Ember.computed.alias 'mappingEffort.currentConcept'
  effort: Ember.computed.alias 'mappingEffort.effort'
  from: Ember.computed.alias 'mappingEffort.from'
  to: Ember.computed.alias 'mappingEffort.to'
  watcher: Ember.inject.service("mapped-concepts-watcher")
  classNames: ["main-header"]
  menuClosed: true

  mappedConceptsResultFrom: Ember.computed 'watcher.pMappedConceptsCountFrom', ->
    @get('watcher.pMappedConceptsCountFrom')
  totalConceptsResultFrom: Ember.computed 'watcher.pTotalConceptsCountFrom', ->
    @get('watcher.pTotalConceptsCountFrom')
  mappedConceptsResultTo: Ember.computed 'watcher.pMappedConceptsCountTo', ->
    @get('watcher.pMappedConceptsCountTo')
  totalConceptsResultTo: Ember.computed 'watcher.pTotalConceptsCountTo', ->
    @get('watcher.pTotalConceptsCountTo')


  init:(params) ->
    this._super(params)
    @get('watcher')

  onClickElsewhere: ->
    @set('menuClosed', true)

  areTaxonomiesSelected: Ember.computed 'from', 'to', ->
    @get('from') and @get('to')

  isConceptSelected: Ember.computed 'concept', ->
    @get('concept') isnt undefined

  isUserAdmin: Ember.computed 'userIsAdmin', 'userIsAdminTester', ->
    @get('userIsAdmin') or @get('userIsAdminTester')

  kpiBars: Ember.computed 'mappedConceptsResultFrom', 'totalConceptsResultFrom', 'mappedConceptsResultTo', 'totalConceptsResultTo', ->
    Ember.RSVP.hash(
      @get('totalConceptsResultFrom')
      @get('totalConceptsResultTo')
      @get('mappedConceptsResultFrom')
      @get('mappedConceptsResultTo')
    )

  actions:
    closeMenu: ->
      @set('menuClosed', true)
    toggleMenu: ->
      @toggleProperty 'menuClosed'

`export default NavBarComponent`
