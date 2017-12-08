`import Ember from 'ember'`
`import HierarchyConfig from '../mixins/hierarchy-config'`

ConceptHierarchyComponent = Ember.Component.extend HierarchyConfig,
  store: Ember.inject.service('store')
  mappingEffort: Ember.inject.service()
  fromTaxonomy: Ember.computed.alias 'mappingEffort.origin'
  toTaxonomy: Ember.computed.alias 'mappingEffort.target'
  effort: Ember.computed.alias 'mappingEffort.effort.id'
  inverted: Ember.computed.alias 'mappingEffort.inverted'
  direction: undefined
  invertedObserver: Ember.observer 'inverted', (->
    if @get('inverted') then @set('direction',"To")
    else @set('direction',"From")
  ).on('init')
  actions:
    switchHierarchies: ->
      @sendAction 'switchHierarchies'
    activateItem: (item) ->
      @sendAction 'activateItem', item



`export default ConceptHierarchyComponent`
