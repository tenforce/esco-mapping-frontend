`import Ember from 'ember'`

ConceptMappingsComponent = Ember.Component.extend
  classNames: ["concept-mappings"]
  classNameBindings: [ "fullDetail:open" ]
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  mappingEffort: Ember.inject.service()
  fromTaxonomy: Ember.computed.alias 'mappingEffort.from'
  toTaxonomy: Ember.computed.alias 'mappingEffort.to'
  detail: null
  toggleTooltip: Ember.computed 'fullDetail', ->
    if @get 'fullDetail'
      "collapse"
    else
      "expand"
  fullDetail: Ember.computed 'user.showMappings', 'detail', ->
    detail = @get 'detail'
    if Ember.isBlank(detail)
      @get('user.showMappings') == "yes"
    else
      detail
  mappings: Ember.computed 'mappingEffort.inverted', 'concept.mappingsFrom.@each.matchType', 'concept.mappingsTo.@each.matchType', 'concept.mappingsTo.@each.status', 'concept.mappingsFrom.@each.status', ->
    if @get('mappingEffort.inverted') then prom = @get('concept.mappingListTo')
    else prom = @get('concept.mappingListFrom')
    prom
  mappingsLength: Ember.computed 'mappings', ->
    @get('mappings').then (mappings) ->
      mappings.get('length')
  actions:
    toggleDetail: ->
      @toggleProperty 'fullDetail'


`export default ConceptMappingsComponent`
