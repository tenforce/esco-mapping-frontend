`import Ember from 'ember'`

###
# Select an existing mapping effort
###
SelectEffortComponent = Ember.Component.extend
  classNames: ['effort']
  store: Ember.inject.service()
  from: Ember.computed.alias 'effort.from'
  to: Ember.computed.alias 'effort.to'
  isAllowed: Ember.computed.bool 'effort'
  effort: undefined
  efforts: Ember.computed ->
    @get('store').findAll('mapping-effort', include: 'from,to')
  sortedEfforts: Ember.computed.sort 'efforts', (a, b) ->
    if a.get('label') > b.get('label') then return 1
    else if a.get('label') < b.get('label') then return -1
    else return 0
  actions:
    selectEffort: (effort) ->
      @set('effort',effort)
    selectTaxonomies: ->
      params = {effort:@get('effort.id')}
      @sendAction("taxonomiesSelected", params)

`export default SelectEffortComponent`
