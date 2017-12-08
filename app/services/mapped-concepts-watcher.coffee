`import Ember from 'ember'`

MappingCreatedWatcherService = Ember.Service.extend
  # TODO : The way to handle refresh is quite ugly. It would be cleaner to refactor this.
  mappingEffort: Ember.inject.service()
  toggleRefresh: true
  from: Ember.computed.alias 'mappingEffort.from'
  to: Ember.computed.alias 'mappingEffort.to'
  effort: Ember.computed.alias 'mappingEffort.effort.id'
  refreshToggle: true

  init: ->
    @._super()
    @get('mappingEffort')
    @initRefreshBar()

  initRefreshBar: ->
    @refresh()
    Ember.run.later(
      =>
        @initRefreshBar()
      60000
    )


  refresh: ->
    if @get('refreshToggle')
      @set('refreshToggle', false)
    else
      @set('refreshToggle', true)
    Ember.RSVP.hash(
      totalFrom: @get('pTotalConceptsCountFrom')
      mappedFrom: @get('pMappedConceptsCountFrom')
      totalTo: @get('pTotalConceptsCountTo')
      mappedTo: @get('pMappedConceptsCountTo')
    )

  pTotalConceptsCountFrom: Ember.computed "refreshToggle", "from.id", -> new Ember.RSVP.Promise (resolve) =>
    if @get('from.id')
      Ember.$.ajax({
        url: "/kpis/c72b89ca-ca30-46c5-b191-0c7bf62d3d0d/run",
        crossDomain: true,
        type: "GET",
        data:{
          "kpi-taxonomySource": @get 'from.id'
        },
        success: (response) =>
          resolve(response.data.attributes.total)
        error: (error) =>
          resolve(0)
      })


  pMappedConceptsCountFrom: Ember.computed "refreshToggle"  , "effort", -> new Ember.RSVP.Promise (resolve) =>
    if @get('from.id')
      Ember.$.ajax({
        url: "/kpis/e9f1cc43-5a4e-43b3-a41e-3f369182a140/run",
        crossDomain: true,
        type: "GET",
        data:{
          "kpi-direction": "mapsFrom"
          "kpi-mappingEffort": @get 'effort'
        },
        success: (response) =>
          resolve(response.data.attributes.total)
        error: (error) =>
          resolve(0)
      })

  pTotalConceptsCountTo: Ember.computed "refreshToggle", "to.id", -> new Ember.RSVP.Promise (resolve) =>
    if @get('to.id')
      Ember.$.ajax({
        url: "/kpis/c72b89ca-ca30-46c5-b191-0c7bf62d3d0d/run",
        crossDomain: true,
        type: "GET",
        data:{
          "kpi-taxonomySource": @get 'to.id'
        },
        success: (response) =>
          resolve(response.data.attributes.total)
        error: (error) =>
          resolve(0)
      })


  pMappedConceptsCountTo: Ember.computed "refreshToggle"  , "effort", -> new Ember.RSVP.Promise (resolve) =>
    if @get('to.id')
      Ember.$.ajax({
        url: "/kpis/e9f1cc43-5a4e-43b3-a41e-3f369182a140/run",
        crossDomain: true,
        type: "GET",
        data:{
          "kpi-direction": "mapsTo"
          "kpi-mappingEffort": @get 'effort'
        },
        success: (response) =>
          resolve(response.data.attributes.total)
        error: (error) =>
          resolve(0)
      })

`export default MappingCreatedWatcherService`
