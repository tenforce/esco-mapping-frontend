`import Ember from 'ember'`

ConceptSuggestionComponent = Ember.Component.extend
  tagName: ""
  titleAcceptButton: Ember.computed 'mappingExist', ->
    if @get 'mappingExist' then return "This suggestion has been accepted"
    else return "Accept this suggestion"
  titleHideButton: Ember.computed 'mappingExist', 'hidden', ->
    if @get 'mappingExist' then return "Accepted suggestions are always hidden"
    else if @get 'hidden' then return "Show this suggestion"
    else return "Hide this suggestion"
  shouldDisplay: Ember.computed 'hideCompletedSuggestions', 'suggestion.status', ->
    if @get('hideCompletedSuggestions')
      if @get('suggestion.status') is "hidden"
        false
      else
        true
    else true

  hidden: Ember.computed 'suggestion.status', ->
    if @get('suggestion.status') is 'hidden'
      return true
    else
      return false

  mappingExist: Ember.computed 'suggestion.mapping.status', ->
    if ["todo", "approved"].contains @get('suggestion.mapping.status')
      return true
    else
      return false

  concept: Ember.computed 'suggestion', 'inverted', ->
    if @get('inverted') then target = "from"
    else target = "to"
    @get('suggestion').get(target)
  actions:
    acceptSuggestion: (suggestion)  ->
      @sendAction('acceptSuggestion', suggestion)

    rejectSuggestion: (suggestion) ->
      unless @get('mappingExist')
        @sendAction('rejectSuggestion', suggestion)

`export default ConceptSuggestionComponent`
