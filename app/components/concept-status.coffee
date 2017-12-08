`import Ember from 'ember'`
`import ComputeStatus from '../mixins/compute-status'`

ConceptStatusComponent = Ember.Component.extend ComputeStatus,
  classNames:["info"]
  store: Ember.inject.service('store')
  mappingEffort: Ember.inject.service()
  targetTaxonomy: Ember.computed.alias 'mappingEffort.to'
  originTaxonomy: Ember.computed.alias 'mappingEffort.from'
  concept: Ember.computed.alias 'model'
  hasConceptStatus: Ember.computed.notEmpty 'conceptStatus'
  hasMappingStatus: Ember.computed.notEmpty 'mappingStatus'
  modelObserver: Ember.observer 'model', 'model.isMappable', 'model.mappingsFrom.@each.matchType', 'model.mappingsTo.@each.matchType', 'targetMappingStatus', (->
    @get 'model'
    @get('targetMappingStatus').then (status) =>
      if status
        unless @get('isDestroyed') then @set 'conceptStatus', status.get('status').toLowerCase().split(" ").join("-")
      else
        unless @get('isDestroyed') then @set 'conceptStatus', "in-progress"
      switch @get 'conceptStatus'
        when "to-be-reviewed" then unless @get('isDestroyed') then @set 'tooltipConceptStatus', 'this concept needs review'
        when "approved" then unless @get('isDestroyed') then @set 'tooltipConceptStatus', 'this concept is approved'

    if @get 'model.isMappable'
      inverted = @get('mappingEffort.inverted')
      mappings = if inverted then @get('model.mappingListTo') else @get('model.mappingListFrom')
      mappings.then (results) =>
        if results.get('length') > 0
          unless @get('isDestroyed')
            @set 'mappingStatus', 'mapped'
            @set 'tooltipMappingStatus', 'this concept has mappings'
        else
          unless @get('isDestroyed') then @set 'mappingStatus', 'unmapped'
    else
      unless @get('isDestroyed') then @set 'mappingStatus', null
  ).on('init')

`export default ConceptStatusComponent`
