`import Ember from 'ember'`
`import {sortByPromise} from 'ember-esco-plugins'`
`import ENV from '../config/environment'`

HierarchyConfigMixin = Ember.Mixin.create
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  displayLanguage: Ember.computed "user.language", "user.showIscoInChosenLanguage", ->
    if @get('user.showIscoInChosenLanguage') == "yes"
      @get('user.language') or "en"
    else
      "en"
  language: Ember.computed.oneWay 'user.language'
  status: 'all'

  ###
  # Builds a filter object that is compatible with the taxonomy-browser's filter requirements
  ###
  filters: Ember.computed  'inverted', 'effort', ->
    filterConfig = ENV.filters

    self = this
    filters = filterConfig.map (current) ->
      filter =
        name: current.name
        id: current.id
        params: {}
      current.variables?.map (name) ->
        filter.params[name] = self.get name
      filter

    filters.unshift
      name: "All"
      id: null
      params: {}
    filters

  config: Ember.computed 'defaultExpanded', 'displayLanguage', ->
    # if display language changes, fetch the concepts again
    @get 'displayLanguage'
    # property path to the property that should be used as label
    # e.g. model.label.en would be label.en
    Ember.Object.create
      labelPropertyPath: 'preflabel'
      onActivate: (node) =>
        @send 'activateItem', node
      # list of concept ids that are expanded
      # will auto expand a node in the tree if it's id is contained in this array
      expandedConcepts: []
      # max amount (n) of children to be shown before a load more button is presented
      # load more button shows an extra n children
      showMaxChildren: 50
      noScroll: true
      # route used in link-to of the node
      linkToRoute: 'concepts.show'
      afterComponent: 'concept-status'
      beforeComponent: 'concept-notation'

`export default HierarchyConfigMixin`
