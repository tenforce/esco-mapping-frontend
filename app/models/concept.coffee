`import DS from 'ember-data'`
`import ESCO from 'ember-esco-concept-description'`

Concept = DS.Model.extend ESCO.Concept,
  languagePreference: ["en", "de"]
  isco: DS.attr('string')
  codes: DS.attr('string-set')
  code: null
  defaultCode: Ember.computed 'codes', ->
    filtered = @get('codes')?.filter (code) ->
      if (code.search 'CTC') is -1
        return true
      else return false
    if filtered
      filtered[0]
    else
      ""
  definition: null
  isMappable: DS.attr('string')
  defaultPrefLabel: Ember.computed.alias 'preflabel'
  preflabel: Ember.computed 'prefLabels', 'languagePreference', ->
    langs = @get 'languagePreference'
    @get('prefLabels').then (labels) ->
      best = null
      langs.map (lang) ->
        best ||= labels.filterBy('language', lang)?[0]?.get('literalForm')
      best || labels.objectAt(0)?.get('literalForm')
  iscoCode: Ember.computed 'isco', ->
    # prefixed http://data.europa.eu/esco/isco2008/Concept/C
    @get('isco')?.substring(45)
  nace: DS.attr('string')
  naceCode: Ember.computed 'nace', ->
    # prefixed http://data.europa.eu/esco/ConceptScheme/NACErev2/c.
    @get('nace')?.substring(52)
  mappingsFrom: DS.hasMany('mapping', {inverse: 'from'})
  mappingsTo: DS.hasMany('mapping', {inverse: 'to'})
  mappingStates: DS.hasMany('mapping-state', {inverse: null})
  topConceptOf: null
  mappingEffort: Ember.inject.service()
  currentEffort: Ember.computed.alias "mappingEffort.effort"
  getMappings: (inverted) ->
    if inverted
      @get 'mappingListFrom'
    else
      @get 'mappingListTo'
  mappingListFrom: Ember.computed 'currentEffort.id', 'mappingsFrom.@each.matchType', 'mappingsFrom', 'mappingsFrom.@each.state', ->
    currentEffort = @get('currentEffort.id')
    @get('mappingsFrom').then (mappings) ->
      promises = []
      mappings.forEach (map) ->
        promises.push(map.get('mappingEffort'))
      Ember.RSVP.all(promises).then =>
        ret = mappings.filter (item) ->
          if not item.get('matchType') or item.get('matchType') is "no"
            return false
          if item.get('mappingEffort.id') is currentEffort then return true
          return false
        ret
  mappingListTo: Ember.computed 'currentEffort.id', 'mappingsTo.@each.matchType', 'mappingsTo', 'mappingsTo.@each.status', ->
    currentEffort = @get('currentEffort.id')
    @get('mappingsTo').then (mappings) ->
      promises = []
      mappings.forEach (map) ->
        promises.push(map.get('mappingEffort'))
      Ember.RSVP.all(promises).then =>
        ret = mappings.filter (item) ->
          if not item.get('matchType') or item.get('matchType') is "no"
            return false
          if item.get('mappingEffort.id') is currentEffort then return true
          return false
        ret

  anyChildren: true
  hasChildren: Ember.computed "anyChildren", ->
    return @get('anyChildren')


  defaultDescription: Ember.computed 'description.@each.language', ->
    @get('description')?.filterBy('language', @get('defaultLanguage'))?.get('firstObject.content')


`export default Concept`
