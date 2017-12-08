`import Ember from 'ember'`

ConceptMappedComponent = Ember.Component.extend
  classNameBindings: ["mappedState"]
  attributeBindings: ["title"]
  mappingEffort: Ember.inject.service()
  targetObserver: Ember.observer 'model', 'model.isMappable', 'config.target', 'config.target.mappingsFrom.@each.matchType', 'config.target.mappingsTo.@each.matchType', (->
    if not @get('model.isMappable') or (not @get('config.target.mappingsFrom') and not @get('config.target.mappingsTo'))
      @set 'mappingEffort', null
      return
    inverted = @get 'mappingEffort.inverted'
    if not inverted
      mappings = @get 'config.target.mappingsFrom'
      pathTarget = "to"
    else
      mappings = @get('config.target.mappingsTo')
      pathTarget = "from"
    mappings.then (results) =>
      promises = []
      results.forEach (result) ->
        promises.push(result.get(pathTarget))
      Ember.RSVP.all(promises).then =>
        @set 'mappedState', 'unmapped'
        @set 'title', 'you can map this concept to the current concept'
        results.forEach (result) =>
          if result.get(pathTarget).get('id') is @get('model.id') then foundit = true
          if foundit
            @set 'mappedState', 'mapped'
            @set 'title', 'this concept is mapped to the current concept'
  ).on('init')

`export default ConceptMappedComponent`
