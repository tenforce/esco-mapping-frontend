`import DS from 'ember-data'`

Suggestion = DS.Model.extend
  clusterName: undefined
  textualScore: 0
  contextualScore: 0
  floodingScore: 0
  combinedScore: 0
  label: undefined
  sourceUri: undefined
  sourceUuid: DS.attr('string')
  targetUri: undefined
  targetUuid: DS.attr('string')
  status: DS.attr('string')
  mapping: DS.belongsTo('mapping', { inverse: null })
  mappingEffort: DS.belongsTo('mappingEffort', { inverse: null })

  roundScore: (number) ->
    Math.round(number * 10) / 10
  roundedTextualScore: Ember.computed 'textualScore', ->
    @roundScore(@get('textualScore'))
  roundedContextualScore: Ember.computed 'contextualScore', ->
    @roundScore(@get('contextualScore'))
  roundedFloodingScore: Ember.computed 'floodingScore', ->
    @roundScore(@get('floodingScore'))
  roundedCombinedScore: Ember.computed 'combinedScore', ->
    @roundScore(@get('combinedScore'))

`export default Suggestion`
