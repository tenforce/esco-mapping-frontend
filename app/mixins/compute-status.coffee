`import Ember from 'ember'`

ComputeStatusMixin = Ember.Mixin.create
  targetMappingStatus: Ember.computed 'targetTaxonomy', 'originTaxonomy', 'concept.mappingStates.@each.status', ->
    @get('concept.mappingStates').then (statusses) =>
      effort = @get('mappingEffort.effort.id')
      promises = []
      statusses.forEach (status) =>
        promises.push(status.get('mappingEffort'))
      Ember.RSVP.all(promises).then =>
        stat = statusses.filter (item) ->
          if effort is item.get('mappingEffort.id') then return true
          else return false
        if stat.length is 0 then return undefined
        else return stat[0]

`export default ComputeStatusMixin`
