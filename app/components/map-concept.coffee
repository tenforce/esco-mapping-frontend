`import Ember from 'ember'`
`import HierarchyConfig from '../mixins/hierarchy-config'`

MapConceptComponent = Ember.Component.extend HierarchyConfig,
  store: Ember.inject.service('store')
  mappingEffort: Ember.inject.service()
  classNames: ["map-concept"]
  taxonomy: Ember.computed.alias 'mappingEffort.target'
  # for filtering
  effort: Ember.computed.alias 'mappingEffort.effort.id'
  direction: Ember.computed 'mappingEffort.inverted', ->
    if @get 'mappingEffort.inverted'
      'From'
    else
      'To'
  activateNode: (node) ->
    if node.get('isMappable')
      @sendAction 'createMapping', node
  deleteNode: (node) ->
    if node.get('isMappable')
      @sendAction 'deleteMapping', node
  baseConfig: Ember.computed 'concept', ->
    target: @get 'concept'
    afterComponent: 'concept-mapped'
  fullConfig: Ember.computed 'baseConfig', 'config', ->
    Ember.Object.create @get('config'), @get('baseConfig')

  selectedAction: 'browse'
  actions:
    activateItem: (node) ->
      @activateNode(node)
    acceptSuggestion: (suggestion) ->
      @sendAction('acceptSuggestion', suggestion)
    rejectSuggestion: (suggestion) ->
      @sendAction('rejectSuggestion', suggestion)
    selectAction: (action) ->
      @set('selectedAction', action)

`export default MapConceptComponent`
