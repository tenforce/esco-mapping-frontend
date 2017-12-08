`import Ember from 'ember'`

ExportMappingsComponent = Ember.Component.extend
  mappingEffort: Ember.inject.service()
  effort: Ember.computed.alias 'mappingEffort.effort'

`export default ExportMappingsComponent`
