`import Ember from 'ember'`

###
# A service to track the state of the mapping platform. Keeps track of the taxonomy to map from and
# to and whether the mapping viewpoint is inverted or not
###
MappingEffortService = Ember.Service.extend
  currentConcept: undefined
  effort: undefined
  from: undefined
  to: undefined
  inverted: false
  origin: Ember.computed 'from', 'to', 'inverted', ->
    if @get 'inverted'
      @get 'to'
    else
      @get 'from'
  target: Ember.computed 'from', 'to', 'inverted', ->
    if @get 'inverted'
      @get 'from'
    else
      @get 'to'


`export default MappingEffortService`
