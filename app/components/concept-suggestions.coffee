`import Ember from 'ember'`

ConceptSuggestionsComponent = Ember.Component.extend
  init: ->
    @._super()
    @get('mappingEffort.effort')
  tagName: 'div'
  classNames: ['suggestions']
  store: Ember.inject.service('store')
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  mappingEffort: Ember.inject.service()
  inverted: Ember.computed.alias 'mappingEffort.inverted'
  hideCompletedSuggestions: Ember.computed 'user.showCompletedSuggestions', ->
    if @get('user.showCompletedSuggestions') is 'yes'
      return false
    else
      return true

  displaySuggestions: Ember.computed 'hideCompletedSuggestions', 'emptySuggestions', 'suggestions', ->
    hideComplete = @get 'hideCompletedSuggestions'
    if @get('emptySuggestions') then return false
    if @get('hideComplete') is false then return true
    filtered = @get('suggestions').filter (suggestion) ->
      if suggestion.get('status') is "hidden" then return false
      return true
    if filtered.length is 0 then return false
    return true
  emptySuggestions: Ember.computed 'suggestions.length', ->
    if @get('suggestions.length') > 0 then return false
    else return true

  loading: false
  isLoading: Ember.computed 'loading', ->
    @get('loading')

  conceptObserver: Ember.observer('concept', () ->
    @initSuggestions()
  ).on('init')

  sortTypes:
    [
      {
        label: 'Combined'
        property: 'roundedCombinedScore'
      },
      {
        label: 'Textual'
        property: 'roundedTextualScore'
      },
      {
        label: 'Contextual'
        property: 'roundedContextualScore'
      },
      {
        label: 'Flooding'
        property: 'roundedFloodingScore'
      }
    ]
  sortType:
    label: 'Combined'
    property: 'combinedScore'
  sortedSuggestions: Ember.computed 'suggestions', 'sortType', ->
    suggestions = @get 'suggestions'
    sortType = @get 'sortType.property'
    unless suggestions and sortType then return []
    suggestions.sort (a, b) ->
      if a.get(sortType) < b.get(sortType) then return 1
      if a.get(sortType) > b.get(sortType) then return -1
      return 0
  suggestions: undefined
  initSuggestions: () ->
    @set('loading', true)
    from = @get('mappingEffort.from.id')
    to = @get('mappingEffort.to.id')
    locale = @get('mappingEffort.effort.locale') || "en"
    unless locale then locale = "en"
    if not @get('mappingEffort.inverted')
      source = from
      target = to
    else
      source = to
      target = from

    Ember.$.ajax(
      url: '/indexer/search/similar/full',
      type: 'GET',
      data: {
        'sourceConceptScheme': source,
        'targetConceptScheme': target,
        'locale': locale
        'sourceConceptUUID': @get('concept.id'),
        'numberOfResults': 50
      },
      contentType: "application/json"
    ).then (result) =>
      array = []
      promises = []
      result.data.forEach (suggestion) =>
        attributes = suggestion.attributes
        promises.push(@get('store').query('suggestion',
          {
            filter:
              'mapping-effort': { id: @get('mappingEffort.effort.id') }
              'source-uuid': @get('concept.id')
              'target-uuid': attributes.targetUuid
            page: {size: 100, offset: 0}
          }
        ).then (fetchedSuggestions) =>
          if fetchedSuggestions.get('length') > 0
            if attributes.floodingScore is undefined then attributes.floodingScore=0
            if attributes.textualScore is undefined then attributes.textualScore=0
            if attributes.contextualScore is undefined then attributes.contextualScore=0
            if attributes.combinedScore is undefined then attributes.combinedScore=0
            fetch = fetchedSuggestions.get('firstObject')
            if fetch.get('status') is undefined then fetch.set('status', 'shown')
            fetch.set('clusterName', attributes.clusterName)
            fetch.set('floodingScore', attributes.floodingScore)
            fetch.set('textualScore', attributes.textualScore)
            fetch.set('contextualScore', attributes.contextualScore)
            fetch.set('combinedScore', attributes.combinedScore)
            fetch.set('label', attributes.label)
            fetch.set('sourceUri', attributes.sourceUri)
            fetch.set('targetUri', attributes.targetUri)
            array.push(fetch)
          else
            generated = @get('store').createRecord('suggestion', attributes)
            generated.set('status', 'shown')
            generated.set('sourceUuid',@get('concept.id'))
            generated.set('mappingEffort',@get('mappingEffort.effort'))
            array.push(generated)
        )
      Ember.RSVP.Promise.all(promises).then =>
        @set('suggestions', array)
        @set 'loading', false
        return array

  toggleBooleanProp: (name) ->
    current = @get name
    if current == "yes"
      @set name, "no"
    else
      @set name, "yes"

  actions:
    acceptSuggestion: (suggestion) ->
      @sendAction('acceptSuggestion', suggestion)

    rejectSuggestion: (suggestion) ->
      @sendAction('rejectSuggestion', suggestion)

    toggleCompletedSuggestions: ->
      @toggleBooleanProp 'user.showCompletedSuggestions'

`export default ConceptSuggestionsComponent`
